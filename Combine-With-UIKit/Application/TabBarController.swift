//
//  TabBarController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import UIKit

class TabBarController: UITabBarController,  UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = UINavigationController(rootViewController: KeyboardViewController()) // 네비게이션 컨트롤러 없는 뷰컨트롤러
        //탭바를 아름답게 꾸며주겠습니다. 타이틀도 넣어주고 이미지도 넣어줍니다.
        let tabOneBarItem = UITabBarItem( title: nil, image: UIImage(systemName: "keyboard.fill"), tag: 0)
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: WeatherViewController()) // 뷰컨 품은 네비게이션 컨트롤러
        let tabTwoBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "sun.max"), tag: 1)
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabThree = UINavigationController(rootViewController: InputViewController())
        let tabThreeBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "arrowshape.down.circle.fill"), tag: 2)
        tabThree.tabBarItem = tabThreeBarItem
        
        let tabFour = UINavigationController(rootViewController: StateBindingViewController())
        let tabFourBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "arrow.trianglehead.2.clockwise"), tag: 3)
        tabFour.tabBarItem = tabFourBarItem
        
        let tabFive = UINavigationController(rootViewController: TestDrivenViewController())
        let tabFiveBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "wrench.and.screwdriver"), tag: 4)
        tabFive.tabBarItem = tabFiveBarItem
        
        //탭바컨트롤러에 뷰 컨트롤러를 array형식으로 넣어주면 탭바가 완성됩니다.
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour, tabFive]
    }
}
