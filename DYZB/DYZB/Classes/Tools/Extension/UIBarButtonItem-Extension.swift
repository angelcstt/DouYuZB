//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 蔡四堂 on 2017/9/2.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    //创建工具类，用来完成UIBarButtonItem的快速创建
    /*class func creatItem(imageName : String, highImageName : String, size : CGSize) ->UIBarButtonItem{
    
        let btn = UIButton()
        
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
        
    
    }*/
    
    //创建构造函数
    // MARK - 创建UIbutton工具构造函数
    convenience init(imageName : String,highImageName : String = "",size : CGSize = CGSize.zero){
        
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        //设置button图片
        if highImageName != ""{
        btn.setImage(UIImage(named : highImageName), for: .highlighted)
        }
        //设置button尺寸
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    
    
    
    }
    
}
