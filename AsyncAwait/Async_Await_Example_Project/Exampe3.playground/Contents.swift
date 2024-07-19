import UIKit
import Foundation


//여러 비동기 작업 병렬 실행
func fetchData1() async -> String {
    await Task.sleep(1 * 1_000_000_000)
    return "Data 1"
}

func fetchData2() async -> String {
    await Task.sleep(2 * 1_000_000_000)
    return "Data 2"
}

Task {
    async let data1 = fetchData1()
    async let data2 = fetchData2()

    let results = await (data1, data2)
    print("Results: \(results.0), \(results.1)")
}

/*
 비동기 함수를 병렬로 실행하는 코드
 
 1. Task{ ... } 를 통해 비동기 작업 생성
 2. async let data1 = fetchData1() -> fetchData1()함수를 비동기로 실행, 결과를 data1에 할당
 3. async let data2 = fetchData2() -> fetchData2()함수를 비동기로 실행, 결과를 data2에 할당
 4. let results = await (data1, data2) -> data1과 data2의 결과가 모두 준비된 후 (data1, data2)로 결과를 반환
 5. print("Results: \(results.0), \(results.1)") 출력
 
 -> print결과로만 생각하면 동기처리가 된다고 생각할 수 있다.
    그러나 결과가 print로 같이 반환 될 뿐 동기 작업은 아니다.
    data1은 이미 데이터가 할당된 상태이고 data2의 데이터가 할당되고 나서야
    print가 출력되기 때문에 동기처리되어 순차로 실행되는 듯한 느낌을 받을 수 있음 ㅇㅇ
 
    -> 비동기 처리로 fetchData1, fetchData2가 동시에 실행 되긴함
        await 키워드 때문에 결과를 모두 기다린 후에 다음으로 넘어가기대문
    Q) 그럼 비동기로 실행되지만 최종 결과를 얻기 위해서 시간이 소요될 수도 있다?
    A) ㅇㅇㅇ 특정 작업이 완료되어야 결과를 반환 받을 수 있기 때문
 
 */
