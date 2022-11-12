//
//  NetworkManager.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import RxSwift

protocol Networkable {
    func request(endPoint: Endpoint) -> Observable<Data>
}

final class NetworkManager: Networkable {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func request(endPoint: Endpoint) -> Observable<Data> {
        return Single<Data>.create { single in
            let urlRequest: URLRequest

            switch endPoint.generateUrlRequest() {
            case .success(let request):
                urlRequest = request
            case .failure(let error):
                single(.failure(error))
                return Disposables.create()
            }

            let task = self.urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let result = self?.checkError(with: data, response, error) else {
                    return
                }

                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create()
        }
        .asObservable()
    }

    private func checkError(
        with data: Data?,
        _ response: URLResponse?,
        _ error: Error?
    ) -> Result<Data, NetworkError> {
        if let error = error as? NetworkError {
            return .failure(error)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(NetworkError.responseError)
        }

        guard (200..<300).contains(response.statusCode) else {
            return .failure(NetworkError.statusCodeError(statusCode: response.statusCode))
        }

        guard let data = data else {
            return .failure(NetworkError.emptyDataError)
        }

        return .success(data)
    }
}
