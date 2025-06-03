//
//  Bundle.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 6/4/25.
//

import Foundation

extension Bundle {
    var weatherAPIKey: String? {
        return infoDictionary?["Weather_API_Key"] as? String
    }
}
