import UIKit

// 타이머 사용
func startTimer(interval: TimeInterval) async {
    for await _ in Timer.publish(every: interval, on: .main, in: .common).autoconnect().values {
        print("Timer fired at \(Date())")
    }
}

Task {
    await startTimer(interval: 1)
}
