import UIKit

// 비동기 데이터 처리 파이프라인


/**
 비동기로 데이터를 가져옴
 ```Swift
 - await Task.sleep(1 * 1_000_000_000)
    -> 네트워크 요청 시뮬레이션을 위한 1초대기
 
 - return Data("Fetched data".utf8)
    -> Fetched Data 문자를 Data형식으로 변환하여 반환
 
 - async throws
    -> 함수가 비동기로 실행되며 오류를 던질 수 있음을 알림
 ```
 */

func fetchData() async throws -> Data {
    // 네트워크 패치
    await Task.sleep(1 * 1_000_000_000)
    return Data("Fetched data".utf8)
}


/**
 비동기로 데이터를 가져옴
 
 ```Swift
 - await Task.sleep(1 * 1_000_000_000)
    -> 데이터 처리를 시뮬레이션하기 위해 1초 동안 대기
 
 - return String(data: data, encoding: .utf8) ?? "Processing failed"
    -> 입력된 Data를 문자열로 변환하여 반환. 변환에 실패하면 "Processing failed"를 반환.
 
 - async
    -> 함수가 비동기적으로 실행됨을 나타냄.
 ```
 
 */
func processData(_ data: Data) async -> String {
    // Simulate data processing
    await Task.sleep(1 * 1_000_000_000)
    return String(data: data, encoding: .utf8) ?? "Processing failed"
}


/**
비동기로 데이터 저장
 
 ```Swift
 - await Task.sleep(1 * 1_000_000_000)
    -> 데이터를 저장하는 작업을 시뮬레이션하기 위해 1초 동안 대기
 
 - print("Data saved: \(processedData)")
    -> 저장된 데이터를 콘솔에 출력
 
 - async
    -> 함수가 비동기적으로 실행됨을 나타냄
 ```
 
 */
func saveData(_ processedData: String) async {
    // Simulate saving data
    await Task.sleep(1 * 1_000_000_000)
    print("Data saved: \(processedData)")
}

Task {
    do {
        let data = try await fetchData()
        let processedData = await processData(data)
        await saveData(processedData)
    } catch {
        print("Error: \(error)")
    }
}

// 데이터를 네트워크에서 가져오고 가져온 데이터를 처리 후, 처리된 데이터를 저장하는 작업을 비동기적으로 수행하는 코드
// 각각의 작업은 순차적으로 수행, 각단계에서 대기시간을 포함함

/*
 1. 데이터를 가져옴
    - fetchData 함수가 호출되어 1초 동안 대기, Fetched Data문자열을 Data형식으로 반환
 
 2. 데이터 처리
    - processData 함수가 호출되어 1초 대기 후 Data를 문자열로 변환하여 반환
 
 3. 데이터 저장
    - saveData 함수가 호출되어 1초 동안 대기 후 처리된 데이터 콘솔에 출력
 
 4. 오류 처리
    - 각 단계에서 발생할 수 있는 오류를 Catch 블록에서 처리
 
 - 비동기 데이터 처리 파이프라인을 구현한 예제
    데이터를 가져오고, 처리하고, 저장하는 작업을 비동기적으로 수행
 - 각 단계는 비동기적으로 실행, 작업이 완료될때까지 대기.
 
 */
