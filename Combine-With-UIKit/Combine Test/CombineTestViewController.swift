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
    
    let publisher = [1, 2, 3, 4, 5].publisher
    publisher.subscribe(NewSubscriber())
    
}

class NewPublisher: Publisher {
    
    typealias Output = Int
    typealias Failure = Never
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
        
    }
    
}

class NewSubscriber: Subscriber {
    
    typealias Input = Int
    typealias Failure = Never
    
    func receive(subscription: any Subscription) {
        // 1. subscriber에게 publisher를 성공적으로 구독했음을 알리고 item을 요청할 수 있음
        print("\(#function) 구독 시작")
        subscription.request(.max(3))
        // Subscription.Demand
        // .none, .unlimited, .max(Int)
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        // 2. subscriber에게 publisher가 element를 생성했음을 알림
        print("\(#function) \(input)")
        return .max(2)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        // 3. subscriber에게 publisher가 정상적으로 또는 오류로 publish를 완료했음을 알림
        print("\(#function) 완료", completion)
    }
}

#Preview {
    CombineTestViewController()
}
