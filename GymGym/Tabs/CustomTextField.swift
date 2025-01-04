//
//  CustomTextField.swift
//  GymGym
//
//  Created by 김보윤 on 8/21/24.
//

import Foundation

import SwiftUI
import UIKit

// UITextField를 SwiftUI에서 사용할 수 있도록 래핑
import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

