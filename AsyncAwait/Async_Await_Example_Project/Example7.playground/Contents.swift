import UIKit
import PlaygroundSupport


//UI업데이트
class ViewController: UIViewController {
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.frame = view.bounds
        label.textAlignment = .center

        Task {
            let text = await fetchText()
            updateLabel(text)
        }
    }

    func fetchText() async -> String {
        await Task.sleep(2 * 1_000_000_000)
        return "Hello, Async/Await!"
    }

    func updateLabel(_ text: String) {
        label.text = text
    }
}

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

