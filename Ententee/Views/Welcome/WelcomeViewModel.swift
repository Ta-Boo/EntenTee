//
//  welcomeViewModel.swift
//  Ententee
//
//  Created by hladek on 14/06/2021.
//

import Foundation
import LocalAuthentication

class WelcomeViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var authenticated = false

    var alert: AlertModel? = nil
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "You need to authorize yourself before accessing the application.") {
                [weak self] success, _ in
                DispatchQueue.main.async {
                    if success {
                        self?.authenticated = true
                    } else {
                        self?.showAlert(title: "Authentication failed", message: "Something went wrong durring authentification. Please try again.")
                    }
                }
            }
        } else {
            showAlert(title: "Touch ID not available", message: "Your device is not configured for Touch ID.")
        }
    }

    func showAlert(title: String, message: String, action: @escaping () -> Void = {}) {
        alert = AlertModel (title: title, message: message, primaryButton: nil, secondaryButton: nil )
        showAlert = true
    }
}
