//
//  PageTitleView.swift
//  DYZB
//
//  Created by macosx on 2017/9/2.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit

//定义代理协议
protocol PageTitleViewDelegate : class {
    func pageTitleView (titleView : PageTitleView, selectedIndex index: Int)
}

//定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)



class PageTitleView: UIView {
    
    
    //定义属性
    public var currentIndex : Int = 0
    public var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    
    //  MARK: -懒加载属性
    
    public lazy var titleLabels : [UILabel] = [UILabel]()
    
    
    public lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
        
        
    }()
    
    public lazy var scrollLine : UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    
    }()
    
    //自定义构造函数
    init(frame: CGRect,titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    }

// mark: -  设置UI界面
extension PageTitleView{
    public func setupUI(){
        //添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        
        //添加title对应的label
        setTitleLabels()
        
        //添加底线和title下面滚动line
        setupBottomMenuAndScrollLine()
       
        
       
        
        
    
    }

    private func setTitleLabels(){
        
    
        for (index,title) in titles.enumerated(){
            
            let labelW : CGFloat = frame.width / CGFloat(titles.count)
            let labeiH : CGFloat = frame.height - kScrollLineH
            let labelY : CGFloat = 0

            
            
            //创建UILabel
            let label = UILabel()
            
            //设置UILabel的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            
            //设置Label的Frame
           
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labeiH)
            
            //将Label添加到scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)

            
            
            
            
        }
    
    
    }
    
    private func setupBottomMenuAndScrollLine(){
        //添加底线
        let buttomLine = UIView()
        
        buttomLine.backgroundColor = UIColor.lightGray
        
        let lineH :CGFloat = 0.5
        
        buttomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(buttomLine)
        
        //添加scrollLine
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange   
        
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


//监听label点击
extension PageTitleView{
    //事件监听一定要在定义方法前加上@objc
    @objc public func titleLabelClick(tapGes : UITapGestureRecognizer){
        
        //print("葵花点穴手！")
        //获取当前label下标值
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //获取之前的label下标
   
        let oldLabel = titleLabels[currentIndex]
       
        //切换文字颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.01) {
        self.scrollLine.frame.origin.x = scrollLineX
            
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    
    }
    

}
//暴露的方法
extension PageTitleView{
    func setTitleWithProgress(progress : CGFloat,sourceIndex : Int,targetIndex : Int) {
        //取出sourcelabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //处理颜色渐变
        
    
        
    }
}


