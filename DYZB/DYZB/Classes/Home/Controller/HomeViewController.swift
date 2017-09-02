//
//  HomeViewController.swift
//  DYZB
//
//  Created by 蔡四堂 on 2017/9/2.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    public lazy var pageContentView : PageContentView = {[weak self] in
        
        //确定内容的Frame
        let contentH = kScreenH - kStatusBarH - kNagivationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNagivationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        
        //确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVcs.append(vc)
            
        
        }
        
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self!)
        
        contentView.delegate = self
        
        return contentView
        
    
    
    }()
    public lazy var pageTitleView : PageTitleView = {[weak self] in
      
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNagivationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        //titleView.backgroundColor = UIColor.blue
        titleView.delegate = self
        return titleView
        
        
    }()
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
       
        //设置UI界面
        setupUI()
        
    }
    


}

// MARK:- 设置UI界面
extension HomeViewController{

    public func setupUI(){
        //不需要调整scrollview64内边距
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        //添加titleview
        view.addSubview(pageTitleView)
        //添加contentview
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
        
        
        
    
    }
    
    private func setupNavigationBar(){
        //设置左侧item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon")
    
        
        //设置右侧item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
}


//遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate{
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
         pageContentView.setCurrentIndex(currentIndex: index)
    }
    
}
//遵守PageContentViewDelegate协议

extension HomeViewController : PageContentViewDelegate{
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}
    
    



