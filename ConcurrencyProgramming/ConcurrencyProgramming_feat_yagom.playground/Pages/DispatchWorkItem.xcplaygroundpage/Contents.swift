//: [Previous](@previous)

import Foundation

import Foundation

let red = DispatchWorkItem {
    for _ in 1...5 {
        print("🥵🥵🥵🥵🥵")
        sleep(1)
    }
}

let yellow = DispatchWorkItem {
    for _ in 1...5 {
        print("😀😀😀😀😀")
        sleep(1)
    }
}

let blue = DispatchWorkItem {
    for _ in 1...5 {
        print("🥶🥶🥶🥶🥶")
        sleep(2)
    }
}

// 1
//DispatchQueue.global().async(execute: yellow)
//DispatchQueue.global().sync(execute: blue)
//DispatchQueue.main.async(execute: red)
// 2
//DispatchQueue.global().sync(execute: yellow)
//DispatchQueue.global().async(execute: blue)
//DispatchQueue.main.async(execute: red)
// 3
//DispatchQueue.main.async(execute: yellow)
//DispatchQueue.global().async(execute: blue)
//DispatchQueue.global().sync(execute: red)
// 4
DispatchQueue.main.async(execute: yellow)
DispatchQueue.global().async(execute: blue)
DispatchQueue.global().sync(execute: red)

//: [Next](@next)
