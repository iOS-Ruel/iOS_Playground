import UIKit
import Foundation


//이해가 안가는 것들 모음

// 동시성 제어

class Counter {
    private var value = 0
    private let queue = DispatchQueue(label: "CounterQueue")

//    func increment() async {
//        await queue.async {
//            self.value += 1
//            print("Counter value: \(self.value)")
//        }
//    }
//
//    func getValue() async -> Int {
//        await queue.async {
//            return self.value
//        }
//    }
    func increment() async {
           // withCheckedContinuation을 사용하여 비동기 작업이 완료될 때까지 기다립니다.
           await withCheckedContinuation { continuation in
               queue.async {
                   self.value += 1
                   print("Counter value: \(self.value)")
                   // 비동기 작업이 완료되면 continuation을 호출하여 다음 작업으로 넘어갑니다.
                   continuation.resume()
               }
           }
       }

       func getValue() async -> Int {
           // withCheckedContinuation을 사용하여 비동기 작업이 완료될 때 값을 반환합니다.
           return await withCheckedContinuation { continuation in
               queue.async {
                   // 비동기 작업이 완료되면 값을 반환합니다.
                   continuation.resume(returning: self.value)
               }
           }
       }
}

Task {
    let counter = Counter()
    await withTaskGroup(of: Void.self) { group in
        for _ in 1...10 {
            group.addTask {
                await counter.increment()
            }
        }
    }
    let finalValue = await counter.getValue()
    print("Final counter value: \(finalValue)")
}
