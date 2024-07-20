import UIKit


// 비동기 시쿼스 사용
// AsyncStream를 사용하여 비동기적으로 숫자를 생성하고 소비하는 예제
// AsyncStream를 사용하면 비동기 데이터 스트림을 생성하고 이를 비동기적으로 처리할 수 있음
// 각 숫자는 1초 간격으로 생성되고, 스트림의 모든 숫자가 처리되면 종료됨
// AsyncStream 참고내용 : https://ios-daniel-yang.tistory.com/45


/**
 AsyncStream를 통한 비동기 데이터 스트림 생성
 - 제네릭 타입으로 Int를 사용하여 정수를 생성하는 스트림 생성
 
 1. AsyncStream 생성
    - AsyncStream는 비동기 스트림을 생성함
    - 제네릭타입으로 Int를 사용하여 정수를 생성하는 스트림을 만듦
 2. 클로저(continuation)
    - continuation은 스트림에 데이터를 추가하거나 스트림을 종료하는데 사용
    - 클로저 안에서 for 루프 실행
 3. 데이터 생성 (yield)
    - for i in 1...10 반복문이 1부터 10까지 반복
    - `continuation.yield(i)`는 현개값 i를 스트림에 추가
    - sleep(1) : 각 숫자를 1초 간격으로 생성
 4. 스트림 종료 (finish)
    - 모든 숫자를 생성한 후 continuation.finish()를 호출하여 스트림 종료
 */
func generateNumbers() -> AsyncStream<Int> {
    AsyncStream { continuation in
        for i in 1...10 {
            continuation.yield(i)
            sleep(1)
        }
        continuation.finish()
    }
}

Task {
    for await number in generateNumbers() {
        print("Received number: \(number)")
    }
    print("All numbers received")
}
/*
 1. 스트림 생성:
     -> generateNumbers 함수가 호출되어 AsyncStream을 생성.
     -> 스트림은 1부터 10까지의 숫자를 1초 간격으로 생성.

 2. 숫자 생성:
    -> for i in 1...10 루프가 실행되며, 각 숫자가 1초 간격으로 생성되고 스트림에 추가
    -> 각 숫자가 스트림에 추가되면 continuation.yield(i)가 호출
 
 3. 스트림 소비:
    -> Task 블록 내의 for await 루프가 실행되며, 스트림에서 숫자를 비동기적으로 가져
    -> 각 숫자가 생성될 때마다 "Received number: (number)" 메시지가 출력
 
 4. 스트림 종료:
    -> 모든 숫자가 생성되면 continuation.finish()가 호출되어 스트림이 종료
    -> 스트림이 종료되면 "All numbers received" 메시지가 출력
 
 주요 포인트
 - 비동기 스트림: AsyncStream을 사용하여 비동기 데이터 스트림을 생성하고 소비
 - 비동기 반복: for await를 사용하여 비동기적으로 스트림의 데이터를 반복
 - 스트림 제어: continuation을 사용하여 스트림에 데이터를 추가하고, 스트림을 종료
 */
