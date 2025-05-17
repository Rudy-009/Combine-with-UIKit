//
//  ViewModel.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/16/25.
//

import Combine
import Foundation

struct ViewModel {
    
    var count: Int = 0
    
    private mutating func increment() {
        self.count += 1
    }
    
}
