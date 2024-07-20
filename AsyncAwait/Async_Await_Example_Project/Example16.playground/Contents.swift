import UIKit


// 백그라운드에서 작업실행
func performBackgroundTask() async {
    await Task.detached {
        await Task.sleep(2 * 1_000_000_000)
        print("Background task completed")
    }.value
}

Task {
    await performBackgroundTask()
    print("Main task completed")
}
