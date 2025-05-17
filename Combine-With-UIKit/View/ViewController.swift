//
//  ViewController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/16/25.
//

import UIKit

class ViewController: UIViewController {
    
    private let basicView = BasicView()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = basicView
        basicView.button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func handleButtonTapped() {
        viewModel.count += 1
        
    }
    
    
    
    
    
}

