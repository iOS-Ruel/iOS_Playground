import UIKit


//타임아웃

func fetchDataWithTimeOut() async throws -> String {
    try await withThrowingTaskGroup(of: String.self) { group in
        group.addTask {
            await Task.sleep(3 * 1_000_000_000) // 네트워크 딜레이
            return "Fetched data"
        }
        
        group.addTask {
            await Task.sleep(2 * 1_000_000_000)
            throw URLError(.timedOut)
        }
        
        return try await group.next() ?? "No Data"
    }
}

Task {
    do {
        let data = try await fetchDataWithTimeOut()
        print("Data: \(data)")
    } catch {
        print("Error: \(error)")
    }
    
}


/*
 1. Task 그룹 생성
    - withThrowingTaskGroup 사용하여 두개의 작업을 그룹으로 묶음
 
 2. 첫번째 Task
    - 3초간 대기 후 Fetched data반환
 
 3. 두번째 Task
    - 2초간 대기 후 타임아웃 오류 반환
 
 4. 그룹 결과 처리
    - 그룹 내 첫번째로 완료된 작업의 결과를 반환하거나 오류 발생
    - 2초 후 두 번째 작업이 타임아웃 오류를 던지므로 group.next()는 오류를 던짐
 
 5. 결과 출력
    - 작업이 완료되면 결과를 출력하거나 오류가 발생하면 오류메세지 출력
 
 - withThrowingTaskGroup을 사용하여 비동기 작업들을 병렬로 실행한 뒤
    가장 먼저 완료된 작업의 결과를 반환하거나 타임아웃과 같은 오류가 발생하면 처리
 
    -> 여러 API를 호출해야할때 하나라도 오류가 나면 에러일 경우 위와 같이 처리할 수 있음
 
 */
