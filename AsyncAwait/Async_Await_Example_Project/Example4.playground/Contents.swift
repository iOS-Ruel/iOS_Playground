import UIKit



//연속된 비동기 작업 처리

func fetchDataStep1() async -> String {
    await Task.sleep(1 * 1_000_000_000)
    return "Step 1 Completed"
}

func fetchDataStep2() async -> String {
    await Task.sleep(1 * 1_000_000_000)
    return "Step 2 Completed"
}

Task {
    let step1Result = await fetchDataStep1()
    print(step1Result)
    
    
    let step2Result = await fetchDataStep2()
    print(step2Result)
}

/*
 1. 이 코드는 fetchDataStep1과 fetchDataStep2를 순차적으로 실행
 2. 첫 번째 비동기 함수가 완료되면 결과를 출력, 두번째 비동기 함수를 호출하여 완료된 후 결과 출력
 3. 각 함수는 1초 동안 대기하기 때문에 전체 실행시간은 총 2초
 
 -> 비동기 작업을 순차적으로 처리하는 방법
    -> 각 작업이 완료된 후 다음 작업이 시작되며 모든 작업이 완료 된 후 결과 출력
    -> 작업 순서가 중요한 경우 사용할 수 있을 것 같음
 */
