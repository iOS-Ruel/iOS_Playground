import UIKit

public class HippoPaymentsProcessor {

    private let apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    public func processPayment(
        payload: [String: Any],
        onSuccess: @escaping () -> Void,
        onFailure: @escaping (HippoPaymentsError) -> Void
    ) {
        let vc = HippoPaymentsConfirmationViewController()
        vc.onDismiss = onSuccess
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        window?.rootViewController?
            .viewControllerPresentationSource.present(vc, animated: true, completion: .none)
    }
}
