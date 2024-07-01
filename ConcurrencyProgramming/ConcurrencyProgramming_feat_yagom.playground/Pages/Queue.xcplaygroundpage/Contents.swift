//: [Previous](@previous)

import Foundation

let queue1 = DispatchQueue(label: "queue1")
let queue2 = DispatchQueue(label: "queue2")
let queue3 = DispatchQueue(label: "queue3")

queue1.async { () -> Void in
    print(queue1.label)
}

queue2.async { () -> Void in
    print(queue2.label)
}

queue3.async { () -> Void in
    print(queue3.label)
}

print("program stopped")


// 순서가 보장되지 않음

//: [Next](@next)
