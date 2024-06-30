//: [Previous](@previous)

import Foundation

DispatchQueue.global().async {
    for _ in 1...5 {
        print("😀😀😀😀😀")
        sleep(1)
    }
}

DispatchQueue.global().async {
    for _ in 1...5 {
        print("🥶🥶🥶🥶🥶")
        sleep(2)
    }
}

DispatchQueue.main.async {
    for _ in 1...5 {
        print("🥵🥵🥵🥵🥵")
        sleep(1)
    }
}

/*
 위 코드는 main 스레드가 아닌 다른 스레드를 만들어 비동기적으로 처리하고 있음. 
 DispatchQueue.global().async를 이용해서 두 개의 작업을 각각 다른 스레드에서 실행하고,
 DispatchQueue.main.async를 이용해서 메인 스레드에서 또 다른 작업을 실행 함

 결과를 보면 세 가지 작업이 동시에 처리되고 있는 걸 볼 수 있음.
 여러 개의 스레드가 필요하고, 비동기적으로 작업이 처리되어야 이처럼 동시에 작업을 할 수 있음.

 하지만 비동기(async) 특성 때문에 어떤 코드가 먼저 실행될지 예측할 수 없다는 게 문제가 있음.
 각 스레드마다 작업 속도가 다를 수 있어서 개발자가 직접 통제가 불가능 하기 때문에 결과가 랜덤나옴…..
 예측이 불가해서 논리적으로 정확한 순서를 기대하기 어려움.

 */

//: [Next](@next)
