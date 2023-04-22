# 🛠 프로젝트 매니저

## 📖 목차

1. [소개](#-소개)
2. [프로젝트 구조](#-프로젝트-구조)
3. [구현 내용](#-구현-내용)
4. [타임라인](#-타임라인)
5. [실행 화면](#-실행-화면)
6. [트러블 슈팅 &고민했던 점](#-트러블-슈팅--고민했던-점)

## 😁 소개
### 프로젝트 소개
> 프로젝트를 관리하는 `iPad`용 TodoList 앱입니다.
> Todo, Doing, Done 세가지 상태로 할일, 진행 중, 완료를 처리합니다.

### 기술 스택

|프로젝트 구조| 화면구성 | 로컬 DB | 리모트 DB | 의존성 관리도구 |
|-|-|-|-|-|
| `MVVM` |`UIKit` | `CoreData` | `FireBase` | `CocoaPods` | 

### 팀원
| <img src= "https://avatars.githubusercontent.com/u/74972815?v=4" width=150> |
|:---|
|캠퍼: [스톤](https://github.com/lws2269)|
|리뷰어: [올라프](https://github.com/1Consumption)|

## 🛠 프로젝트 구조

### 🌲 Tree
```
.
├── ProjectManager/
│   ├── .swiftlint.yml
│   ├── ProjectManager/
│   │   ├── AppLifeCycle/
│   │   │   ├── AppDelegate.swift
│   │   │   └── SceneDelegate.swift
│   │   ├── Resource/
│   │   │   ├── Assets.xcassets
│   │   │   ├── Info.plist
│   │   │   └── LaunchScreen.storyboard
│   │   ├── Model/
│   │   │   ├── Category.swift
│   │   │   └── Work.swift
│   │   ├── View/
│   │   │   ├── ListCell.swift
│   │   │   ├── ListView.swift
│   │   │   ├── MainViewController.swift
│   │   │   ├── WorkFormController.swift
│   │   │   └── CircleLabel.swift
│   │   └── ViewModel/
│   │       ├── MainViewModel.swift
│   │       ├── WorkFormViewModel.swift
│   │       ├── ListCellViewModel.swift
│   │       └── ListViewModel.swift
│   ├── Products
│   ├── Pods
│   └── FrameWorks    
└── Pods
```
## 📌 구현 내용

### Model
- `Category`
    - work에 대한 상태 todo, doing, done을 가진 enum타입입니다. 해당 상태에 필요한 요소를 반환하는 계산속성을 포함하고있습니다.
- `Work`
    - 각 Cell에 필요한 정보를 가지고 있는 구조체입니다.
### View
- `ListCell`
    - `ListView` -> `tableView`에서 사용되는 CustomCell입니다.
- `ListView`
    - todo, doing, done 각 상태에 대한 정보를 표시하는 커스텀 뷰입니다. tableView를 포함하고 있습니다.
- `MainViewController`
    - 3개의 ListView를 가지고 있는 메인이되는 상위 뷰입니다.
- `WorkFormController`
    - edit, add시 표현되는 모달 View입니다.
- `CircleLabel`
    - ListView 내부에서 각 Category에 대한 갯수를 표현하기 위한 둥글게 커스텀된 UILabel입니다.
### ViewModel
- `MainViewModel`
    - `MainViewController`의 뷰 모델입니다. 해당 뷰모델에서 3개의 ListView에 대한 데이터를 다룹니다..
- `WorkFormViewModel`
    - `WorkFormController`의 뷰 모델입니다. 해당 부분에서 work을 반환하고, 데이터의 업데이트에 대한 부분은 `MainViewModel`에서 다룹니다.
- `ListViewModel`
    - `ListView`에 대한 뷰 모델입니다. category의 count에 대한 내용을 다룹니다.
- `ListCellViewModel`
    - `ListCell`의 뷰 모델입니다.


## 📱 실행 화면
### 새로운 일정 등록
![](https://i.imgur.com/tOOnAoI.gif)
### 상태 변경
![](https://i.imgur.com/bFGyCKv.gif)
### 일정 삭제
![](https://i.imgur.com/tWtjxOc.gif)
### 일정 수정 - edit 버튼 클릭 전까지 비활성화
![](https://i.imgur.com/vl0wY0e.gif)

## ⏰ 타임라인


<details>
<summary>Step1 타임라인</summary>
<div markdown="1">       

- **2023.01.10**
    - 기술스택 선정 `MVVM` + `UIKit`
    
</div>
</details>

<details>
<summary>Step2 타임라인</summary>
<div markdown="1">       

- **2023.01.11**
    - `ListView` 기본 화면 구현
- **2023.01.12**
    - Category, Work 타입 구현
    - `MainListViewController`의 뷰모델 `MainListViewModel` 구현
- **2023.01.13**
    - 프로젝트 Add View `AddViewController` 구현
    - `MainListViewContoller` 내부 로직 구현
    - `ListViewModel` 구현
- **2023.01.15**
    - `WorkDelegate` 프로토콜 추가
    - `WorkManager` 구현
- **2023.01.16**
    - `ListViewModel` 리팩토링
- **2023.01.17**
    - Cell - longPressGesture 구현
    - `WorkManager` 제거 - `MainListViewModel` 내부 로직에서 처리하도록 리팩토링
    - `ListCellViewModel` 구현
- **2023.01.18**
    - `AddViewController` -> `WorkFormViewController` 변경 및 edit, add 기능 통일
    - `WorkFormViewModel` 구현
    - Cell 오토레이아웃 수정
- **2023.01.20**
    - bug : 수정시 update가 아닌 add가 되는 현상 수정
    - 전체적인 리팩토링
    
</div>
</details>


## ❓ 트러블 슈팅 & 고민했던 점
### 기술 스택에 대한 고민
이번 프로젝트에서는 `MVC`패턴이 아닌 `MVVM`패턴을 적용하여 구현하는 것을 목표로 진행하며 러닝커브를 조금이나마 줄이기 위해 기존에 사용해왔던 `UIKit`, `CoreData`를 채택하였습니다.

### UITableView Delegate, Datasource
`MainListViewController`에서 테이블뷰에 대한 딜리게이트와, 데이터소스를 모두 구현하고 셀클릭에 대한 로직을 구현하다 보니 `MainListViewController`에서 테이블 뷰 분기처리하는 부분이 옳지 않다고 판단 되어 `ListView`로 옮겨 진행하였습니다.

**`MainListViewController`에서의 분기처리 했을 시 코드 예시**
```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView {
    case doneListView.tableView:
        return viewModel.doneList.count
    case doingListView.tableView:
        return viewModel.doingList.count
    case todoListView.tableView:
        return viewModel.todoList.count
    default:
        return 0
    }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath)
            as? ListCell else { return ListCell() }

    cell.delegate = self

    switch tableView {
    case doneListView.tableView:
        cell.configureData(work: viewModel.doneList[indexPath.row])
    case doingListView.tableView:
        cell.configureData(work: viewModel.doingList[indexPath.row])
    case todoListView.tableView:
        cell.configureData(work: viewModel.todoList[indexPath.row])
    default:
        break
    }

    return cell
}

func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
               forRowAt indexPath: IndexPath) {

    switch tableView {
    case doneListView.tableView:
        viewModel.deleteWork(data: viewModel.doneList[indexPath.row])
    case doingListView.tableView:
        viewModel.deleteWork(data: viewModel.doingList[indexPath.row])
    case todoListView.tableView:
        viewModel.deleteWork(data: viewModel.todoList[indexPath.row])
    default:
        break
    }
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let workFormViewController = WorkFormViewController()
    let navigationViewController = UINavigationController(rootViewController: workFormViewController)

    switch tableView {
    case doneListView.tableView:
        workFormViewController.viewModel.work = viewModel.doneList[indexPath.row]
    case doingListView.tableView:
        workFormViewController.viewModel.work = viewModel.doingList[indexPath.row]
    case todoListView.tableView:
        workFormViewController.viewModel.work = viewModel.todoList[indexPath.row]
    default:
        break
    }

    workFormViewController.viewModel.isEdit = false
    workFormViewController.delegate = self
    navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet

    present(navigationViewController, animated: true)
}
```

위 코드를 봤을때 분기처리 하는 부분에서 가독성과 로직상 위치가 맞지 않다고 판단되어 아래코드와 같이 리팩토링을 진행하였습니다.
리팩토링 진행할 때 데이터 전달에 관한 것은 아래 프로토콜을 통하여 `MainListViewController`에서 처리하였습니다.

```swift
protocol ListViewDelegate: AnyObject, CellDelegate, WorkFormDelegate {
    func deleteWork(work: Work)
    func presentModal(_ viewController: UIViewController, animated: Bool)
}
```

**ListView에서의 Delegate, Datasource 채택**
```swift

extension ListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.workList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath)
                as? ListCell else { return ListCell() }

        cell.delegate = delegate
        cell.configureData(viewModel: ListCellViewModel(work: viewModel.workList[indexPath.row]))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        delegate?.deleteWork(work: viewModel.workList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workFormViewController = WorkFormViewController()
        let navigationViewController = UINavigationController(rootViewController: workFormViewController)
        
        workFormViewController.viewModel = WorkFormViewModel(work: viewModel.workList[indexPath.row])
                
        workFormViewController.delegate = delegate
        navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        delegate?.presentModal(navigationViewController, animated: true)
    }
}
```

---

[🔝 맨 위로 이동하기](##-프로젝트-매니저)
