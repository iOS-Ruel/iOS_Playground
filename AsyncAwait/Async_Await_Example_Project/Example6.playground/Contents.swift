import UIKit


// 데이터베이스 작업
struct User {
    let id: Int
    let name: String
}

class Database {
    func fetchUser(by id: Int) async throws -> User {
        //데이터베이스에서 데이터 호출한다고 가정하여 딜레이를 줌
        await Task.sleep(1 * 1_000_000_000)
        return User(id: id, name: "Ruel")
    }
}

Task {
    let db = Database()
    do {
        let user = try await db.fetchUser(by: 1)
        print("Fetch User : \(user.name)")
    } catch {
        print("Error Fetched user : \(error.localizedDescription)")
    }
}

/*
 1.  비동기 작업 시작:
    - Task 블록이 실행되어 비동기 작업이 시작
 
 2. 데이터베이스 인스턴스 생성:
    - let db = Database(): Database 클래스의 인스턴스를 생성
 
 3. 사용자 정보 가져오기:
    - let user = try await db.fetchUser(by: 1): fetchUser(by:) 함수가 호출되어 1초 동안 대기 (await Task.sleep(1 * 1_000_000_000)).
    - 1초 후, 사용자 정보가 반환
    - print("Fetch User : \(user.name)"): 가져온 사용자 정보의 이름을 출력 ("Fetch User: Ruel").
 
 4. 오류 처리:
    - catch 블록에서 오류가 발생할 경우, 오류 메시지를 출력 (이 코드에서는 오류가 발생하지 않음).
 */

