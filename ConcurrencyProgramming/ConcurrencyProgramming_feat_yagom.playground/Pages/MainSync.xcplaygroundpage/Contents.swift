//: [Previous](@previous)

import Foundation


/*
 error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x18018199c).
 The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.

 */
//DispatchQueue.main.sync {
//    for _ in 1...5 {
//        print("😀😀😀😀😀")
//        sleep(1)
//    }
//}

/*
 main.sync를 직접 호출하면 deadlock(교착상태)에 빠짐.
 작업이 끝나기를 기다리지 않는 async의 특성과는 반대되는, 작업이 끝나기를 기다리는 sync의 특성때문에 발생함.
 앞서 몇 가지 코드를 작성하며 sync는 코드블록이 처리되기 전까지 다음 코드로 넘어가지 않는 것을 확인함.
 이런 상황을 Block-wait라고 하는데, 코드 블록이 끝나기 전까지 그 스레드에 멈춰있겠다는 뜻임.
 따라서 main 스레드에서 main.sync를 호출하게 되면 main 스레드는 sync의 코드블록이 수행되기를 기다려야함.
 하지만 이때 sync의 코드 블록 역시 멈춰버리게됨. → main 스레드에서 실행되고 있던 코드이기 때문임
 따라서 아무것도 실행되지 못하고 main 스레드는 sync가 끝나기를, sync는 main 스레드를 Block-wait이 끝나기를 기다리는 상태가 되어버림.
 이런 현상은 main 큐이기 때문에 발생하는 현상.
 만약 Serial 큐를 커스텀하여 sync를 실행한다면 에러는 발생하지 않음. main 스레드와는 별개의 문제가 되기 때문임.
 
 */




DispatchQueue.global().async {
    DispatchQueue.main.sync {
        for _ in 1...5 {
            print("😀😀😀😀😀")
            sleep(1)
        }
    }
}

for _ in 1...5 {
    print("🥶🥶🥶🥶🥶")
    sleep(2)
}
/*
 main.sync를 호출할 수 있는 경우도 있음. main 스레드에서 호출하지 않으면됨.
 global 스레드에서 main.sync를 호출한다면 에러 없이 동작함
 */


//: [Next](@next)
