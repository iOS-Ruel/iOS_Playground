import UIKit

//파일 읽기
func readFileContents(at path: String) async throws -> String {
    let url = URL(filePath: path)
    let data = try await URLSession.shared.data(from: url)
    return String(data: data.0, encoding: .utf8) ?? "No Content"
}



Task {
    do {
        let contents = try await readFileContents(at: "~/Desktop/Its Mine/iOS_Playground/AsyncAwait/Text.rtf")
        print("File contents: \(contents)")
    } catch {
        print("Error reading file : \(error)")
    }
}


