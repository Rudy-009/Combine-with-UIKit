//
//  CombineTestViewController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 10/11/25.
//

import Combine
import UIKit

class CombineTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testCombineMain()
    }
    
}

func testCombineMain() {
    
    let publisher = [1, 2, 3].publisher
    publisher.subscribe(NewSubscriber())
    
}

class NewSubscriber: Subscriber {
    
    typealias Input = Int
    typealias Failure = Never
    
    func receive(subscription: any Subscription) {
        // . subscriber에게 publisher를 성공적으로 구독했음을 알리고 item을 요청할 수 있음
        print("\(#function) 구독 시작")
        subscription.request(.none)
        // Subscription.Demand
        // .none, .unlimited, .max(Int)
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        // 2. subscriber에게 publisher가 element를 생성했음을 알림
        print("\(#function) \(input)")
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        // subscriber에게 publisher가 정상적으로 또는 오류로 publish를 완료했음을 알림
        print("\(#function) 완료", completion)
    }
}

#Preview {
    CombineTestViewController()
}
