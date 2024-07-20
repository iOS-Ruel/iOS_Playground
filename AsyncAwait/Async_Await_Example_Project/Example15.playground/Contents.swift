import UIKit


//비동기 작업 재시도
func fetchWithRetry(url: URL, retries: Int) async throws -> Data {
    var attempts = 0
    while attempts < retries {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            attempts += 1
            if attempts == retries {
                throw error
            }
            await Task.sleep(2 * 1_000_000_000) // Exponential backoff
        }
    }
    throw URLError(.badServerResponse)
}

Task {
    let url = URL(string: "https://www.naver.com")!
    do {
        let data = try await fetchWithRetry(url: url, retries: 3)
        print("Data fetched successfully: \(data)")
    } catch {
        print("Failed to fetch data after 3 attempts: \(error)")
    }
}
