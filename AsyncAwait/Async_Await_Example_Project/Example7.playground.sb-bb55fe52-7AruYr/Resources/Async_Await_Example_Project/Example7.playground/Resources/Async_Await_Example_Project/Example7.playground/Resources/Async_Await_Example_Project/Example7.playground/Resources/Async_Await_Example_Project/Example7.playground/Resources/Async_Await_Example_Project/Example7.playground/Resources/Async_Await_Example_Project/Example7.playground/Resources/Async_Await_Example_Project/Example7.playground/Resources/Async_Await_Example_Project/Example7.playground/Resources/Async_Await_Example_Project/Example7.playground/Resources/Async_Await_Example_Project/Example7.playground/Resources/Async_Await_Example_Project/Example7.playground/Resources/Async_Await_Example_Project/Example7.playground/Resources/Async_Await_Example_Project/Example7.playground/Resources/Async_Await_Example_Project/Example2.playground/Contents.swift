import UIKit

//네트워크 요청을 통한 데이터 가져오기
struct User: Codable {
    let id: Int
    let name: String
}

func fetchUserData() async throws -> User {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users/1")!
    let data = try await URLSession.shared.data(from: url)
    let user = try JSONDecoder().decode(User.self, from: data.0)
    return user
}

func fetchUserData2() async throws -> User {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users/2")!
    let data = try await URLSession.shared.data(from: url)
    let user = try JSONDecoder().decode(User.self, from: data.0)
    try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    return user
}


Task {
    do {
        let user = try await fetchUserData()
        let user2 = try await fetchUserData2()
        print("User name: \(user.name)")
        print("User name2: \(user2.name)")
    } catch {
        print("Error Fetch user Data")
    }
}
/*
 1. Task 블록이 실행되면 비동기 작업 시작
 2. 첫 번째 네트워크 요청을 fetchUserData함수를 통해 실행되고 결과가 반환될때까지 기다림
 3. 첫 번째 요청이 완료되면 두 번째 네트워크 요청이 fetchUserData2 함수를 통해 실행되고 결과가 반환될때까지 기다림
 4. 두요청이 완료되면 사용자이름 출력
 5. 하나라도 에러가 발생하면 catch블록에서 에러발생
 
 - 동작을 보면 비동기가 아니고 동기처럼 동작하는 것이라고 생각되었음.
    - await 를 통해서 비동기 작업이 완료될때까지 기다린 후 다음줄이 실행되기 떄문
 따라서 동기코드처럼 순차적으로 실행되는 것처럼 보임
 */
