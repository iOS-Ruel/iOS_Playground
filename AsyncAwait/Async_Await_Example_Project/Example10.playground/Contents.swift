import UIKit



func downloadImage(url: URL) async throws -> UIImage {
    let data = try await URLSession.shared.data(from: url)
    guard let image = UIImage(data: data.0) else {
        throw URLError(.badServerResponse)
    }
    return image
}


Task {
    do {
        let url = URL(string: "https://picsum.photos/250/250")!
        let image = try await downloadImage(url: url)
        print("Image download Success : \(image)")
    } catch {
        print("Error download image: \(error)")
    }
    
}
