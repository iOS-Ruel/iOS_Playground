import UIKit
import Foundation

//비동기 함수
func fetchUserName() async -> String {
    await Task.sleep(2 * 1_000_000_000)
    return "iOS Dev Ruel"
}

func fetchUserNames() -> [String] {
    return ["Ruel", "Jhon", "MadCow"]
}


Task {
    let userName = await fetchUserName()
    print("Fetch User Name: \(userName)")
}

let userNames = fetchUserNames()
print("Fetch User Names: \(userNames)")

/*
 위와 같이 실행하게 된다면
 fetchUserNames() 결과가 먼저 출력되고
 2초뒤 fetchUserName()이 결과가 출력됨
 
 실행 순서
 1. Task 블록 내의 코드가(fetchUserName()) 비동기로 동작되고 백그라운드에서 2초간 대기
 2. fetchUserNames()가 메인 스레드에서 호출되어 결과를 반환하고
 3. fetchUserNames()의 결과가 출력
 4. 2초 후 fetchUserName() 결과 출력
 */
