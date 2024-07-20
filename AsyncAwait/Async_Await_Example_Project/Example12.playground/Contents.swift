import UIKit

// # 반복 작업의 비동기처리


/**
 number 값을 기반으로 비동기 작업 수행
 
 ```Swift
 - await Task.sleep(UInt64(number) * 1_000_000_000)
    -> 주어진 number초 동안 대기
 
 - print("Task \(number) completed")
    -> 대기가 완료된 후 Task \(number) completed 메세지 출력
 
 - async
    -> 함수가 비동기적으로 실행됨을 나타냄
 ```
 
*/
func performTask(number: Int) async {
    await Task.sleep(UInt64(number) * 1_000_000_000)
    print("Task \(number) completed")
}

Task {
    for i in 1...5 {
        await performTask(number: i)
    }
    print("All Tasks Completed")
}

/*
 1. 비동기 작업 시작
    - Task 블록 실행으로 비동기 작업 시작

 2. 반복문 실행
    - for i in 1...5  1부터 5까지 반복 실행
    - 반복 시  await performTask(number: i) 호출
 
 3. 비동기 작업 수행
    - await performTask(number: i)가 호출되면 i초 동안 대기
    - 대기가 완료되면 Task \(number) completed 출력
    - 5번 반복 후 모든 작업이 완료되면 All Tasks Completed 출력
 */
