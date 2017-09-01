//
//  HomeViewController.swift
//  DYZB
//
//  Created by 蔡四堂 on 2017/9/2.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
       
        
        setupUI()
        
    }
    


}

// 设置UI界面
extension HomeViewController{

    public func setupUI(){
        //设置导航栏
        setupNavigationBar()
        
        
    
    }
    
    private func setupNavigationBar(){
        //设置左侧item
        let btn = UIButton()
        
        btn.setImage(UIImage(named : "homeLogoIcon"), for: .normal)
        
        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    
        
        //设置右侧item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem.creatItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        
        let searchItem = UIBarButtonItem.creatItem(imageName: "searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
        
        let qrcodeItem = UIBarButtonItem.creatItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
}
