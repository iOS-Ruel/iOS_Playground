# VIPER_ToDoList
- VIPER 연습을 위한 ToDoList
- 좀 오래된 아티클이였지만 간단하게 예제로 사용하기에 가치가 있다고 판단하여 해당 아티클을 가지고 VIPER - TodoList를 구현함
</br>
[참고 아티클](https://medium.com/swift2go/building-todo-list-ios-app-with-viper-architecture-bc954ea371bb)

### 폴더구조
```bash
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Entities
│   ├── TodoItem.swift
│   └── TodoStore.swift
├── Resource
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   └── Contents.json
│   │   └── Contents.json
│   ├── Base.lproj
│   │   └── LaunchScreen.storyboard
│   └── Info.plist
├── TodoDetailModule
│   ├── TodoDetailInteractor.swift
│   ├── TodoDetailPresenter.swift
│   ├── TodoDetailProtocols.swift
│   ├── TodoDetailRouter.swift
│   └── TodoDetailViewController.swift
└── TodoListModule
    ├── TodoListInteractor.swift
    ├── TodoListPresenter.swift
    ├── TodoListRouter.swift
    ├── TodoListViewController.swift
    └── TodoProtocols.swift
```

### VIPER란?
- VIPER는 모듈/화면 내부의 구성요소를 단일 책임 원칙에 따라 분리함.
    - 다른 구성요소와 결합도가 낮아지고 모듈화가 가능해짐
    - 각 구성요소간 경계를 나타내는 프로토콜/인터페이스로인해 단위 테스트 및 통합테스트가 간단해짐
<br></br>
- VIPER는 5가지 구성요소로 나누어짐
    1. <b>View</b>: 사용자 Interface 표시 및 사용자 입력을 Presenter에 전달
    2. <b>Interactor</b>: 비지니스 로직을 처리, Persenter
    3. <b>Presenter</b>: Interactor로 부터 데이터를 가져와서 뷰에 어떻게 표시할지 처리, <br>뷰로부터 사용자 입력을 받아 Interactor에게 전달하여 데이터를 가져오거나 업데이트
    4. <B>Entity</b>: Interactor가 사용하는 모델 객체<br>
        Interactor는 별도 데이터 저장소 객체로부터 Entity를 가져옴
    5. <b>Routing/Wireframe</b>: Presenter가 요청하는 탐색 로직을 처리.<br>
    다은 모듈/화면과의 상호 작용 담딩

### VIPER 사용하여 TodoList 앱 구현
- VIPER를 사용하여 간단한 TodoList 구현
    - Server 연동없이 TodoStore 사용
    1. TodoItem Entity, TodoStore: TodoItem은 제목과 내용을 나타냄<br>
    TodoStore는 TodoItem 배열을 저장하는 데이터 저장소
    2. TodoList Module: 사용자에게 TodoItem목록을 TableView로 표시<br>
    새로운 TodoItem  추가 및 삭제, 상세 페이지로 이동하는 기능 담당
    3. TodoDetail Module: TodoItem의 내용 표시 및 사용자에게 TodoItem을 삭제하거나 편집할 수 있는 기능 제공<br>
    TodoList Module로 이동
    4. SceneDelegate: TodoListRouter에서 TodoListView 인스턴스화 하여 RootViewController 설정


![흐름](https://github.com/user-attachments/assets/c73fc445-5b61-4f10-a8af-df9c6b099759)

### 후기
- 해당 프로젝트를 진행하면서 앞선 프로젝트보다 조금더 이해를 할 수 있었음.
- 코드 구현의 순서, 진행흐름을 이해하였음
    - 기존에는 코드 구현의 순서, 진행흐름에 대하여 헷갈리는 부분이 있었음
- Interactor는 MVVM의 ViewModel, Presenter는 Coordinator 라고 생각이 듦
