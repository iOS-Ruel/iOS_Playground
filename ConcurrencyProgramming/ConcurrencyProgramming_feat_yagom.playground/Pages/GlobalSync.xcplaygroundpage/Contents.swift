//: [Previous](@previous)

import Foundation

DispatchQueue.global().sync {
    for _ in 1...5 {
        print("😀😀😀😀😀")
        sleep(1)
    }
}

DispatchQueue.global().sync {
    for _ in 1...5 {
        print("🥶🥶🥶🥶🥶")
        sleep(2)
    }
}

for _ in 1...5 {
    print("🥵🥵🥵🥵🥵")
    sleep(1)
}


/*
 global() 메서드는 새로운 스레드를 생성하고, 그 위에서 작업을 처리해주는 메서드임.
 위 코드는 main 스레드가 아닌 다른 스레드를 만들어 동기적으로 작업을 처리해주는 코드.

 세 코드 블록의 스레드는 각각 다르지만 동기적으로 일을 처리하고 있기 때문에 각각의 작업이 끝나기를 기다림.
 따라서 코드 블록이 작성된(호출된) 순서대로 출력되고 있음
 */
//: [Next](@next)
