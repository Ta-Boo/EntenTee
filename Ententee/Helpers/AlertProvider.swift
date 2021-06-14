import Foundation
import SwiftUI

struct AlertModel{
    let title: String
    let message: String
    let primaryButton: AlertButton?
    let secondaryButton: AlertButton?
}

struct AlertButton {
    let label: String
    let action: () -> Void
}
extension Alert {
    enum type {
        case full(AlertModel), dismiss(AlertModel), cancel(AlertModel)
    }

    init(_ type: Alert.type) {
        switch type {
        case .full(let model):
            self.init(title: Text(model.title),
                      message: Text(model.message),
                      primaryButton: .default(Text(model.primaryButton?.label ?? ""),
                                              action: model.primaryButton?.action ?? {}),
                      secondaryButton: .default(Text(model.secondaryButton?.label ?? ""),
                                                action: model.secondaryButton?.action ?? {}))
        case .cancel(let model):
            self.init(title: Text(model.title),
                      message: Text(model.message),
                      primaryButton: .default(Text(model.primaryButton?.label ?? ""),
                                              action: model.primaryButton?.action ?? {}),
                      secondaryButton: .cancel(Text("Cancel")))
        case .dismiss(let model):
            self.init(title: Text(model.title),
                      message: Text(model.message),
                      dismissButton: .cancel())
        }
    }
}
