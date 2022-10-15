# 📚 iOS-malrang-BookFinder
> 프로젝트 기간 2022.10.12 ~ 2022.10.15    
개발자 : [malrang](https://github.com/malrang-malrang) 

# 📋 목차
- [프로젝트 소개](#-프로젝트-소개)
- [프로젝트 실행화면](#-프로젝트-실행화면)
- [개발환경 및 라이브러리](#-개발환경-및-라이브러리)
- [App 구조](#-app-구조)
- [고민한점, 트러블 슈팅](#-고민한점-트러블-슈팅)
- [커밋 룰](#-커밋-룰)

---
## 🔎 프로젝트 소개
[Google Books API](https://developers.google.com/books/docs/overview)를 이용한 도서 검색 어플입니다.

<img src="https://i.imgur.com/saioHUl.png" width="850">

---
## 📺 프로젝트 실행화면
|MainScene|Search&Result|Pagenation|DetailScene|
|--|--|--|--|
|<img src="https://i.imgur.com/HSYPk1n.gif" width="180">|<img src="https://i.imgur.com/eF6ii2U.gif" width="180">|<img src="https://i.imgur.com/DYrTVfQ.gif" width="180">|<img src="https://i.imgur.com/WBFx3Z9.gif" width="180">|

---
## 🛠 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.0-orange)]() [![xcode](https://img.shields.io/badge/Xcode-14.0.1-blue)]() [![iOS](https://img.shields.io/badge/iOS-14.1-red)]() [![Snapkit](https://img.shields.io/badge/Snapkit-5.0-orange)]() [![RxSwift](https://img.shields.io/badge/RxSwift-6.5-green)]() [![RxCocoa](https://img.shields.io/badge/RxCocoa-6.5-green)]()

---
## 🗂 App 구조
### Coordinator
<img src="https://i.imgur.com/KDXkc4m.png" width="600">

#### Coordinator 적용한 이유
- 이전 프로젝트 에서 각각 다른 View 에서 동일한 View로 화면전환시 화면전환을 하기위한 중복코드가 생겨나고, 각 다른 View에서 동일한 Class 인스턴스를 주입받아야 하는 상황이 발생해 이를 해결하고자 Coordinator 패턴에 대해 공부하고 사용해보았습니다.
- Coordinator 패턴을 적용해 화면 전환 로직을 ViewController 에서 분리 하였고, ViewController 간의 의존성을 제거 하였습니다.

### MVVM, CleanArchitecture
<img src="https://i.imgur.com/nB50IBY.png" width="800">

#### 적용한 이유
- 기존 MVVM의 경우 MVC보다는 계층이 분리되고, 객체들의 관심사가 분리되지만 그럼에도 ViewModel의 역할이 커지는 문제가 발생했습니다.
- CleanArchitecture를 통해 Layer를 한층 더 나누어 주면서 계층별로 관심사가 나누어지게 되고, 자연스럽게 각각의 객체들의 역할이 나누어 지도록 하였습니다.
- 이로 인해 객체들의 결합도가 낮아지고, 응집도는 높아지면서 문제가 발생했을 때 쉽게 찾을 수 있고 해당 부분만 수정이 가능해지면서 유지보수적인 측면에서 상당한 이점을 갖을 수 있게 되었습니다.

---
## 🤔 고민한점, 트러블 슈팅
### 1. API가 제공하는 모든 정보 받아오기 vs 앱에서 사용할 정보만 받아오기
이전 프로젝트 까지는 API가 제공하는 정보가 많지 않았기 때문에 API가 제공하는 모든 정보를 가져올수 있도록 모델을 정의했다.

하지만 이번 프로젝트 같은 경우 API가 제공하는 정보가 많아 모든 정보를 가져올수있는 모델을 만들것인지 앱에서 사용할 정보만을 가져올 모델을 만들것인지 고민했다.

이번 프로젝트를 진행하기전 코드는 변경 혹은 확장(기능 추가)을 쉽게할수 있도록 작성 해야 한다라는 생각이 강했다.

그렇기 때문에 앱의 기능이 추가될경우 앱에서 사용하는 정보가 추가될 가능성을 염두하여 API에서 제공하는 모든 정보를 코드만 보고 알수있기를 바랬다. 

그렇게 API의 모든 정보를 받아올수있는 DTO모델을 만들고, 현재 앱에서 사용하는 정보만을 소유하는 모델을 따로 만들어 주었다.

하지만 이번 API는 제공하는 정보양이 꽤나 많았는데 이번보다 정보양이 더많다면 어떻게 할것인지는 조금더 고민해봐야 할것같다.

### 2. View의 구성을 변경하기 쉽게하자
앱에서 추후 기능이 변경된다면 View의 구성이 달라질수있다고 생각했다.

예를 들면 현재앱의 MainView는 Search기능을 갖는 View로 구성되어있다. 하지만 MainView에 Search기능도 있고 새로 출판된책을 홍보 하기위한 이벤트 페이지가 포함되도록 변경하게 된다면!? 혹은 MainView에서 Search기능 말고 다른 기능을 가진View로 변경해야 한다면 어떻게 해야할까!?

고민끝에 View를 일종의 모듈처럼 구성하여 갈아끼우거나 위치, 사이즈를 조정할수 있게끔 만들어야 겠다 생각했다.

![](https://i.imgur.com/sfnPomF.png)

각각 화면의 최상단에 위치한 ViewController는 화면에 보여줄NavigationItem과 View(UIView 혹은 UIViewController)를 소유 하게끔하고 소유한 View는 ViewController의 view에 할당 하는것이 아닌 제약으로 어떠한 위치와 사이즈로 보여줄것인지 구성해주었다.

추후 ViewController가 소유한 View를 다른 View로 갈아끼우거나, 위치와 사이즈를 변경할수 있도록 하기 위함이다.

### 3. 키보드의 검색 버튼을 입력했을때 뿐만아니라 키워드를 입력할때마다 Request를 요청할수 없을까?? (rx.text로 변경된 text감지하기)

#### 4줄 요약
1. RxCocoa의 text (SearchBar.rx.text)를 이용해 text변경시 Request를 요청하도록 구현함.
2. 의도한것과 다르게 처음 키워드를 입력할때와 키보드 제거시 Request요청 하는 문제가 발생함.
3. text Definition을 확인해보니 SearchBar의 text가 nil일경우 "" 으로 옵셔널바인딩 하는것과 키보드제거(편집 종료) 되었을때도 text를 방출하는것을 확인함.
4. distinctUntilChanged()오퍼레이터를 사용해 동일한 text를 방출하게될경우 무시하도록 하여 문제를 해결함.

처음 API Search기능 구현시 키보드의 검색 버튼을 tap할경우 Request를 요청하도록 했다.
```swift
self.searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
    .bind { [weak self] _ in
        //API Request 요청 메서드
        self?.viewModel.fetchFirstPage(text: self?.searchBar.text)
        self?.endEditing(true)
    }
    .disposed(by: disposeBag)
```
RxSwift를 사용해 구현하였으며 `.editingDidEndOnExit` TextField의 검색 버튼을 tap했을때 발생하는 이벤트를 구독하고있다가 이벤트가 전달되면 API Request를 요청했다.

그리고 `.endEditing`을 사용하여 현재 활성화된 SearchBar를 비활성화 하도록했다.(SearchBar를 사용해 검색중이었으면 당연히 SearchBar가 활성화 되어있을테니 `.endEditing`을 사용하면 FirstResponder인 SearchBar가 비활성화 되고 키보드가 제거된다!)

해당 기능을 구현후 쿠팡앱을 이용해 냉동식품을 검색하던중 키워드를 입력할때마다 입력한 키워드가 포함된 예상 검색어 목록 을 보여주는 tableView 를 보게 되었고 Book Finder앱에서도 키워드를 검색할때마다 Request를 요청해 입력한 키워드와 일치하는 정보를 가진 책정보들을 보여주도록 하는것으로 변경하였다.
```swift
self.searchBar.rx.text.orEmpty
    .bind { [weak self] text in
        //API Request 요청 메서드
        self?.viewModel.fetchFirstPage(text: text)
    }
    .disposed(by: self.disposeBag)
```
위의 코드를 살펴보자!
RxCocoa의 text를 사용하게되면 SearchBar에 입력된 text가 변경 될때마다 text에 입력된 String 값을 전달해주는데 이때 옵셔널값으로 전달해준다.
입력을했는데!? 왜 옵셔널값으로 받아야하지!? text가 변경될경우 무조건 값이 있어야 하는데!?

.orEmpty를 사용해서 옵셔널을 걸러주었다!
그후 전달된 text로 API Request를 요청해주었는데 문제가 발생했다.

키워드를 입력하기전에 String = "" 값으로 Request를 요청하게 되고, 키보드가 제거 되었을때 마지막으로 입력한 값을 한번더 Request 요청하게 된다.

RxCocoa의 text는 SearchBar의 text 값을 변경할때 변경된 값을 전달해주는 녀석으로 알고있었는데 text가 변경되지 않았을때도 이벤트를 전달해주는것으로 추측했다.

text의 Definition을 확인해보니 value를 reutrn 한다.

![](https://i.imgur.com/Poms1qE.png)

그렇담 value는 무엇이냐!?

![](https://i.imgur.com/NHrWsCl.png)

source의 return값을 보면 textDidChange와 didEndEditing를 묶어서 전달하고 text값이 옵셔널일 경우 String = "" 을 전달하는것을 볼수있다!
(SearchBar에 처음 키워드를 입력시 값이 아무것도없는 nil이기 때문에 이를 "" 으로 변경해서 전달해주는것을 알수있다!)

didEndEditing을 보면 UIKit의 searchBarTextDidEndEditing을 호출하는데 이는 SearchBar의 text편집 종료시 편집이 종료되었다고 알려주는 메서드다!

추측한대로 편집이 종료될때(비활성화 되어 키보드가 제거 될때) 마지막으로 입력된 text를 방출하게 되는것이다!

그렇다면 문제를 해결하기위해서는 처음 ""값을 방출하지 않도록 하고, 편집이 종료되었을때 마지막으로 변경했던 text값을 한번더 방출하지 않도록 해주어야 한다!

이전 프로젝트에서 사용해본 [distinctUntilChanged()](https://reactivex.io/documentation/operators/distinct.html)가 생각났다.
distinctUntilChanged() 요녀석은 이전의 이벤트값과, 발생한 이벤트값이 같을경우 전달하지 않도록 하는 오퍼레이터다!

이녀석을 사용하기 위해서는 이전이벤트값과 새로 발생한 이벤트값이 같은지 확인해주어야 하기 때문에 Equatable을 채택한 타입만 사용할수 있지만 String은 Equatable을 채택하고 있기때문에 사용할수있다!

```swift
self.searchBar.rx.text
    .orEmpty
    .distinctUntilChanged()
    .bind { [weak self] text in
        self?.viewModel.fetchFirstPage(text: text)
    }
    .disposed(by: self.disposeBag)
```
요렇게 distinctUntilChanged() 적용했더니 문제가 해결되었다.
처음 "" 값은 SearchBar에 아무것도 입력하지 않았을때는 nil이고 이는곧 ""으로 변경된다.

그후 SearchBar를 활성화 시키게되면 text를 입력하지 않았기 때문에 ""(nil)이 방출되는데 distinctUntilChanged()를 사용해 이전값과 같으면 무시하도록 했기 때문에 ""값이 방출되지 않는다.

그리고 키보드를 제거했을때(편집을 종료했을때)도 마찬가지로 마지막으로 입력한 키워드와 동일한값을 방출하기때문에 무시되므로 원하는 결과를 얻을수 있었다.

### 4. API Request요청시 Query값에 따라 totalItems 값이 바뀌는 Bug
Pagenation 기능을 구현한후 Pagenation기능 동작시 totalItems값이 변경되는것을 확인했다.

<img src="https://i.imgur.com/DYrTVfQ.gif" width="160"> <img src="https://i.imgur.com/PSh4XlA.gif" width="160"> 

Request 요청시 쿼리는 다음과 같다.
**`q=G&startIndex=0&maxResults=20&projection=full`**

위의 쿼리중 q는 검색어를 의미하는데 q의 값은 변하지 않고 Pagenation 동작시 startIndex값을 변경하여 변경된 값의 startIndex부터 maxResults의 값만큼을 더한 Index를 요청하게된다.

**예시)**
startIndex=0, maxResults=20 일경우 0번Index부터 차례대로 20개의 데이터를 요청한다는뜻이다.

startIndex=20, maxResults=20 일경우 20번Index부터 차례대로 20개의 데이터를 요청한다.

그렇다면 Pagenation 기능을 구현하기 위해서는 startIndex의 값을 변경해주면 되는데 검색어는 변하지 않았음에도 totalItems의 값이 변경된것이다..

웹에서 URL을 입력해 검색했을때도 값이 변경된것을 확인할수 있다.

`q=G&startIndex=0&maxResults=20` **totalItems = 892**
![](https://i.imgur.com/Lv4LheE.png)
`q=G&startIndex=20&maxResults=20` **totalItems = 1570**
![](https://i.imgur.com/WziGa5q.png)

해당 문제는 API문제인지 알수없지만 현재 해결하지 못했으며, 추후 원인을 알게된다면 해결방법 내용을 업데이트 하겠습니다.

---
## 📄 커밋 룰
➕[add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성.

✨[feat]: 새로운 기능 구현.

✅[chore]: 코드 수정, 내부 파일 수정.

🔨[fix]: 버그, 오류 해결.

📝[docs]: README나 WIKI 등의 문서 개정.

♻️[refactor]: 전면 수정이 있을 때 사용합니다.

🚚[move]: 프로젝트 내 파일이나 코드의 이동.

✏️[correct]: 주로 문법의 오류나 타입의 변경, 이름 변경.

💄[mod]: storyboard 파일,UI 수정한 경우.

⚰️[del]: 쓸모없는 코드 삭제.

📄[test]: 테스트 코드 작성및 수정.
