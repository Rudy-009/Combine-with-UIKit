//
//  KeyboardViewModel.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import Combine

class KeyboardViewModel: ObservableObject {
    
    @Published var input: String = ""
    @Published var isInputValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $input
            .map{ $0.count >= 5 } // Operator를
            .assign(to: \.isInputValid, on: self)
            .store(in: &cancellables)
    }
    
}
