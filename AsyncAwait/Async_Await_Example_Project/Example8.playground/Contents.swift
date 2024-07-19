import UIKit

class SyncManager {
    private var isDataLoaded = false

    func loadData() async {
        print("loadData")
        if !isDataLoaded {
            await fetchData()
            isDataLoaded = true
        }
    }

    private func fetchData() async {
        await Task.sleep(2 * 1_000_000_000) // 데이터 패치
        print("Data fetched")
    }
}

Task {
    let syncManager = SyncManager()
    await syncManager.loadData()
    await syncManager.loadData() // 데이터를 다시 가져오지 않음
}
