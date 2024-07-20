import UIKit

//비동기 함수 내부에서 동기 함수 호출

func synchronousTask() -> String {
    // Simulate synchronous work
    sleep(1)
    return "Synchronous task result"
}

func asynchronousTask() async -> String {
    return await Task { synchronousTask() }.value
}

Task {
    let result = await asynchronousTask()
    print(result)
}
