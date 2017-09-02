//
//  PageContentView.swift
//  DYZB
//
//  Created by macosx on 2017/9/2.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    
    func pageContentView(contentView : PageContentView,progress : CGFloat,sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    public var childVcs : [UIViewController]
    public weak var parentViewController : UIViewController?
    public var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?

    //懒加载属性
    public lazy var collectionView : UICollectionView = {[weak self] in
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!//强制解包
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建UIcollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        
        
        return collectionView
        
        
        
    
    }()
    
    //创建构造函数
    init(frame: CGRect,childVcs : [UIViewController], parentViewController : UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        
        super.init(frame: frame)
        
        //调用设置UI方法
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//设置UI界面方法
extension PageContentView{

    public func setupUI(){
        //1.将所有的自控制器全部添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加UICollectionView,用于在cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
    
    }

}
//遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        
        //给cell设置内容
        for view in cell.contentView.subviews{
        view.removeFromSuperview()
            
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
        
        
    }

}

//遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断是左划还是右滑
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{//左滑
            //计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
            
                targetIndex = childVcs.count - 1
            
            }
            
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW{
            
                progress = 1
                targetIndex = sourceIndex
                
            }
        
        }else{
            //右滑
            
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            sourceIndex = Int(currentOffsetX / scrollViewW) + 1
            targetIndex = Int(currentOffsetX / scrollViewW)
            if sourceIndex >= childVcs.count{
            sourceIndex = childVcs.count - 1
            
            }
        
        }
        
        //将progress、sourceindex、targetindex传递给titleview
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    
 
}


//对外暴露的方法
extension PageContentView{

    func setCurrentIndex(currentIndex : Int){
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    
    }
}
