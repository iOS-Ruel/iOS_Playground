# SwiftUI_Diary Sampe (with: FastCampus)


## 새로익힌것
- Property Wrappers
@State, @Binding, @Published, @ObservedObject, @StateObject, @Environment, @EnvironmentObject, ObservableObject

### 1. @State 
1. SwiftUI에서 상태를 처리하는 방법
2. 뷰의 상태를 저장하는 프로퍼티로 상태 관리 주체는 해당 뷰
3. 기본적으로 Private 선언이기에 다른 뷰와 값을 소통하려면 Binding이용
4. 값이 변경될 때마다 UI 업데이트<br>
    -> @State 는 현재 해당 뷰에서만 상태변화를 위해 동작함<br>해당 값이 변경되면 UI업데이트를 시켜줌


    ```swift
    struct ContentView: View { 
        @State private var isPlaying: Bool = false

        var body: some View {
            Button(isPlaying ? "Pause" : "Play") { 
                isPlaying.toggle()
            }
        }
    }
    ```

    > isPlaying이라는 프로퍼티는 State 프로퍼티<br>
    Bool 타입으로 true/false 값을 가질 수 있음<br>
    body에 구현된 Button에서 해당 프로퍼티가 true 이면 "Pause", false 이면 "Play"를 UI에 제공<br>
    <b><u>즉, View의 상태를 위해 작용함.</u></b><br> Button 의 action closure에서는 프로퍼티를 toggle 시킴<br>
    사용자가 버튼을 누르면 isPlaying 프로퍼티의 상태가 변경되고 Button text의 문구가 바뀜<br>
    UI업데이트가 isPlaying프로퍼티를 통해 일어남
    <br>
        
### 2. @Binding 
1. 뷰와 상태를 바인딩 하는 방법
2. 상위 @State 변수를 전달 받아 하위 뷰에서 캐치해 변화 감지 및 연결
3. Binding은 다른 뷰가 소유한 속성을 연결하기에 소유권 및 저장 공간이 없음

    ```swift
    struct PlayerView: View { 
        var episode: Episode
        @State private var isPlaying: Bool = false

        var body: some View { 
            Text(episode.title)
                .foregroundStyle(isPlaying ? .primary : .secondary)
            PlayButton(isPlaying: $isPlaying) // 💡Binding
        }
    }
    ```
    ```swift
    struct PlayButton: View { 
        @Binding var isPlaying: Bool

        var body: some View { 
            Button(isPlaying ? "Pause" : "Play") { 
                isPlaying.toggle()
            }
        }
    }
    ```
    > PlayerView에서는 어떤 episode가 play되고 있는지 episode의 title을 보여줌 <br>
    episode를 재생할 수 있는 Button을 나타내고 있음<br>
    여기서 PlayButton View는 하위 View임<br>
    PlayView라는 상위 View에서는 isPlaying이라는 state 프로퍼티를 가지고있고<br>
    이 상태 값을 통해 episode 타이틀을 나타내는 Text에서도 사용함과 동시에 하위 PlayButton에서도 해당 값을 사용하고 싶음<br>
    즉, 해당 State 프로퍼티를 공유하고 싶은 것<br><br>
    그렇다면 하위 View인 PlayButton에서는 상위 View에서 제공하고자하는 isPlaying 프로퍼티를 위해 Binding 프로퍼티로 선언할 수 있음<br>
    하위View에서 Button 구성시 isPlaying 프로퍼티를 이용해 하위 View에서 변화가 감지되면 상위 View에서도 동일하게 공유받아서 상태가 변화하게 됨<br>
    PlayerView 에서 보면 하위 View인 PlayButton을 부를때 PlayButton에 ```$isPlaying```이라고 상위 View가 가진 State 변수를 넣어주고 있음 
    <br>
    -> $는 State변수의 참조를 생성하여 이를 통해 해당 변수의 상태를 다른 뷰나 속성과 양방향으로 바인딩 하는 것을 도와주는 역할을 함

<br>

### 3. ObservableObject > <b><u>클래스 프로토콜임</u></b>
1. 클래스 프로토콜로 관찰하는 어떠한 값이 변경되면 변경사항을 알려줌
2. 뷰에서 인스턴스 변화를 감시하기 위해 뷰모델 객체로 생성할 때 사용할 수 있음

    ```swift 
    class Contact: ObservableObject {
        @published var name: String
        @published var age: Int

        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }

        func haveBirthday() -> Int { 
            age += 1
            return age
        }
    }
    ```
    ```swift 
    let john = Contact(name: "John Appleseed", age: 24)
    cancellable = john.objectWillChange
                    .sink { _ in 
                        print("\(john.age) will change")
                    }
                print(john.haveBirthdat())
    ```
    > Contact는 ObservableObject 프로토콜을 따르고 있음<br>
    @Published 프로퍼티 값이 변경되기 전에 변경된 값을 방출하는 ```objectWillChange``` 퍼블리셔를 사용할 수 있게 만들어 주는 프로토콜임<br>
    두번째 코드 처럼 해당 Contact 객체의 인스턴스에서 john의 나이가 변하는 ```haveBirthday()``` 메서드를 호출하면 퍼블리셔를 통해 해당 "24 will change" 구문이 호출되고 그 후 값이 변경되어 "25"의 값이 출력됨

    <br>
### 4. @Published
1. ObservableObject를 구현한 클래스 내에서 <u>프로퍼티 선언 시</u> 사용
2. <u>@Published로 선언된 프로퍼티를 뷰에서 관찰</u>할 수 있음
3. ObservableObject의 ```objectWillChange.send()```기능을 @Published 프로퍼티가 변경되면 자동으로 호출<br>
    ->뷰와 뷰모델을 바인딩시키고 연결할 때 별도로 Publisher를 구현하거나 처리하는 등에 수고를 덜어낼 수 있음
    <br>

### 5. @ObservedObject
1. 뷰에서 ObservableObject 타입의 인스턴스 선언 시 사용
2. ObservableObject의 값이 업데이트되면 뷰를 업데이트
    ```swift
    class User: ObservableObject { 
        @published var age = 10
    }
    ```
    ```swift 
    struct ContentView: View { 
        @ObservedObject var user: User

        var body: some View { 
            Button("Plus Age") {
                user.age += 1
            }
        }
    }
    ```
    > ObservableObject 프로토콜을 따르는 User 객체<br>
    ContentView는 해당 객체를 ObservedObejct 인스턴스로 선언함<br>
    body에서는 Button을 두어서 User 즉, 인스턴스에 존재하는 age 프로퍼티의 값을 변경시킴<br>
    이렇게 되면 버튼이 눌릴때마다 age의 값은 변경됨, 해당 User객체를 사용하는 곳에서도 동일하게 변경됨<br>
    ObservableObject 프로토콜을 따르는 객체와 View를 ObservedObject인스턴스를 통해 연결지어 사용할 수 있음
    <br>
### 6. @StateObject
1. 뷰에서 ObservableObject 타입의 인스턴스 선언시 사용
2. 뷰마다 하나의 인스턴스를 생성하며, 뷰가 사라지기 전까지 같은 인스턴스 유지
3. @ObservedObject의 뷰 렌더링 시 인스턴스 초기화 이슈 해결을 위한 방법
4. 매번 인스턴스가 새롭게 생성되는 것처럼 외부에서 주입 받는 경우가 아닌 <b><u>최초 생성 선언 시에 @StateObject를 사용하는 것이 적절한 방법</b></u>

### 7. @Environment
1. 미리 정의되어 있는 <b><u>시스템 공유 데이터</u></b>
2. 사용하려는 공유 데이터의 이름을 keyPath로 전달하여 사용
3. ⭐️시스템 공유 데이터는 가변하기에 var로 선언 필요
4. 뷰가 생성되는 시점에 값이 자동으로 초기화됨
    ```swift
    struct ContentView: View{ 
        @Environment(\.colorScheme) var colorScheme

        var body: some View { 
            Text("Hello, world!")
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
    ```
    > ex) 현재 디바이스의 colorScheme을 이용함(라이트 모드, 다크모드)<br>
    colorScheme을 keyPath로 가져와서 colorScheme이라는 변수를 만듬<br>
    body에서 foregroundColor에서 colorScheme의 값이 다크모드인지 라이트모드인지에 따라 컬러를 지정해줌<br>

### 8. @EnvironmentObject
1. ObservableObject를 통해 구현된 타입의 인스턴스를 전역적으로 공유하여 사용
2. <b>앱 전역에서 공통으로 사용할 데이터를 주입 및 사용</b>
    ```swift
    class Info: ObservableObject { 
        @Published var age = 10
    }

    @main
    struct MyApp: App { 
        var body: some Scene {
            WindowGroup { 
                MainView()
                    .environmentObject(Info())
            }
        }
    }

    struct MainView: View { 
        @EnvironmentObject var info: Info 

        var body: some View { 
            Button(action: {
                self.info.age += 1
            }) { 
                Text("Click Me for plus age")
            }
            SubView()
        }
    }

    struct SubView: View { 
        @EnvironmentObject var info: Info

        var body: some View { 
            Button(action: {
            self.info.age -= 1    
            }) { 
                Text("Click Me for minus age)
            }
        }
    }
    ```
    
    > Info 라는 ObservableObject 프로토콜을 채택한 객체가 있음<br>
    해당 객체를 최상단 AppType에서 띄어줄 MyApp에다 environmentObject 메서드를 이용해 해당 객체에 인스턴스를 넣어줌<br>
    MainView에서는 이를 사용하기 위해 EnvironmentObject 프로퍼티를 선언 해두어야함<br>
    body를 보면 SubView를 호출하는데 SubView도 EnvironmentObject 프로퍼티를 선언하고 실제 버튼에서 사용하고 있음<br>
    따라서 SubView, MainView 에서 버튼을 눌러 info.age의 값이 변경되어도 동일한 객체를 사용하기 때문에 Info의 age가 변함<br>
    해당 객체를 어떤 뷰에서나 선언시켜주고 전역적으로 주입시켜 사용할 수 있음<br>
    EnvironmentObject는 데이터를 공유하는 강력한 도구가 될 수 있음 :: 대신 막쓰면 안됨
     
