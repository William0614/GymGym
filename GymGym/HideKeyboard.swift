//
//  HideKeyboard.swift
//  GymGym
//
//  Created by 김보윤 on 8/22/24.
//

import Foundation

import SwiftUI

struct HideKeyboard: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIView(frame: .zero)
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
