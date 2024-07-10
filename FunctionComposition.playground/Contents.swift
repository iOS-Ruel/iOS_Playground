import UIKit


//map을 통해 새로운 Array생성
let result = [1,2,3].map { $0 + 1}.map{ "만 \($0)살"}
print(result)

//옵셔널에도 map이 존재
//옵셔널의 map은 num에 값이 있으면 안전하게 언래핑을 하여
//넘겨주고( { $0 + 1 } ) 실행한뒤
//실행하여 나온 값을 옵셔널에 래핑하여 리턴해줌

//따라서 num이 nil이라면 언래핑 할 값이 없기때문에 출력결과는 nil임
let num: Int? = 1
let result2 = num.map { $0 + 1 }
print(result2)


//Result 타입에도 Map을 사용할 수 있음
//Result 타입은 mapError라는 error을 매핑하는 함수도 있음
let myResult: Result<Int, Error> = .success(2)
let result3 = myResult.map { $0 +  1 }
print(result3)


//Map은 Optional, Sequence, Result, Publisher 이 4가지 타입에 각각 선언되어있음

//Map이 선언되어있는 4가지 타입의 공통점
// 1. Generic타입이다.
//   1) enum Optional<Wrapped>
//   2) associatedtype으로 Element
//        - Sequence는 프로토콜이지만 associatedtype으로 Element타입을 가지고 있음
//   3) enum Result<Success, Failure> where Failure : Error
//   4) assosiatedtype Output

// 2. transform이라는 함수를 인자를 받음
//   1) func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?
//   2) func map<T>(_ transform: (Self.Element) throws -> T) rethows -> [T]
//   3) func map<NewSuccess>(_ transform: (Success) -> NewSuccess) -> Result<NewSuccess, Failure>
//   4) func map<T>(_ transform: @escaping (Self.Output) -> T) -> Publishers.Map<Self, T>

// Map 함수의 공통점
// t: A -> B (A타입을 B타입으로 바꿀때
// F<A> -(map)-> F<B> (F<A>타입을 F<B>타입으로 바꿀 수 있음
// F에는 옵셔널, 시퀀스, result, publisher 가 들어갈 수 있음


//FlatMap
let ageString: String? = "10"
let result4 = ageString.map { Int($0) }

print(result4)
//이때 result4의 타입은 Int?? 이다
// 왜? 옵셔널 String은 옵셔널 String으로 반환하는데 Int의 init은 실패할 수 있기 때문에 옵셔널로 반환됨
// 따라서 옵셔널 옵셔널 Int가 됨
// t: A -> optional<B>
// optional<A> -(map)-> optional<optional<B>>

if let x = ageString.map {Int($0)}, let y = x {
    print(y)
}

if case let .some(.some(x)) = ageString.map(Int.init) {
    print(x)
}

if case let x?? = ageString.map(Int.init) {
    print(x)
}

//위같은 경우 flatMap을 사용함
let result5 = ageString.flatMap(Int.init)
print(result5)

//앱을 사용하면서 내부적으로보면 타입을 변환하면서 동작함

struct MyModel: Decodable {
    let name: String
}

let myLabel = UILabel()

if let data = UserDefaults.standard.data(forKey: "my_data_key") {
    if let model = try? JSONDecoder().decode(MyModel.self, from: data) {
        let welcomeMessage = "Hello, \(model.name)"
        myLabel.text = welcomeMessage
    }
}

let welcomMessage = UserDefaults.standard.data(forKey: "my_data_key")
    .flatMap { try? JSONDecoder().decode(MyModel.self, from: $0)
    }
    .map(\.name)
    .map { "Hello, \($0)" }

myLabel.text = welcomMessage
