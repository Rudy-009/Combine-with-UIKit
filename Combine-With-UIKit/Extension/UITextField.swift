//
//  UITextField.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 7/23/25.
//

import UIKit
import Combine

// UITextField를 위한 Publisher 확장
extension UITextField {
    
    func textDidChangePublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { _ in self.text ?? "" }
            .eraseToAnyPublisher()
    }

}
