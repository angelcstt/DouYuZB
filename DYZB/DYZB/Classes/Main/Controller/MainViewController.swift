//
//  MainViewController.swift
//  DYZB
//
//  Created by 蔡四堂 on 2017/9/2.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
        
        
    }
    
    private func addChildVc(storyName : String){
    
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVc)

    }
   
}



