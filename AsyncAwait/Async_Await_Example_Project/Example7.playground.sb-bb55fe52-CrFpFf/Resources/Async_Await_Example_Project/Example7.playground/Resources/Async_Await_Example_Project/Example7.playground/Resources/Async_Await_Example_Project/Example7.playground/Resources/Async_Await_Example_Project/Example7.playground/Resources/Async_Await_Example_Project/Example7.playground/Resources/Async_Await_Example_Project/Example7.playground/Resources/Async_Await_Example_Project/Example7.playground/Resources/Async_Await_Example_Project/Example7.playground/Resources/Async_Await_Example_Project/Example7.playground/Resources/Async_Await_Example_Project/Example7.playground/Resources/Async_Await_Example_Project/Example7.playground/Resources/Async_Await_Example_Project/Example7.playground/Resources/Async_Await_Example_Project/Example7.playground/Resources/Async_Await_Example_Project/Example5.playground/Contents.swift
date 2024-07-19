import UIKit


//비동기 작업 취소하기

func fetchCancelableData() async throws -> String {
    try Task.checkCancellation()
    await Task.sleep(2 * 1_000_000_000) // 네트워크 요청했다라고 가정
    try Task.checkCancellation()
    return "Fetched Data"
}


let task = Task {
    do {
        let result = try await fetchCancelableData()
        print(result)
    } catch {
        print("Task was cancelled")
    }
}

//취소를 위해 1초 후 실행
Task {
    await Task.sleep(1 * 100_000_000)
    task.cancel()
}

/*
 1. task라는 비동기 작업 생성
    - fetchCancelableData 함수 호출
    - 함수는 처음 취소 여부 확인 후 2초 대기
    - 대기 후 다시 취소여부 확인
    - 취소되지 않았다면 "Fetched Data" 반환
    - 결과 출력
 2. Task { ... } 비동기 작업 생성 1초 대기
    - 1 초 후 task.cancel() 을 호출하여 task 취소
 3. task는 1초 뒤 취소됨
    - fetchCancelableData 함수는 두번의 취소 여부 중 하나에서 CancellationError를 던짐
    - 던져진 에러는 catch 블록에서 체크 되어 "Task was cancelled" 출력
 
 
 * checkCancellation()은 비동기 작업이 취소되었는지 확인하는데 사용됨.
 
 
 */
