//
//  TAXMainViewController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXMainViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
//        addChildViewController("TAXHomeViewController", title: "首页", image: "tabbar_home")
//        addChildViewController("TAXMessageViewController", title: "消息", image: "tabbar_message_center")
//        addChildViewController("TAXDiscoverViewController", title: "发现", image: "tabbar_discover")
//        addChildViewController("TAXProfileViewController", title: "我", image: "tabbar_profile")
        guard let jsonPath = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil) else{
            print("没有找到资源文件")
            return
        }
        guard let jsonData = NSData(contentsOfFile: jsonPath) else{
            print("获取数据失败")
            return
        }
//        do{
//            let dicArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
//            
//        }catch{
//            print(error)
//        }
        guard let anyObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) else{
            return
        }
        guard let dicArray = anyObject as? NSArray else{
            return
        }
        
        for dict in dicArray {
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            
            // 4.2.获取控制器显示的title
            guard let title = dict["title"] as? String else {
                continue
            }
            
            // 4.3.获取控制器显示的图标名称
            guard let imageName = dict["imageName"] as? String else {
                continue
            }
            
            // 4.4.添加子控制器
            addChildViewController(vcName, title: title, image: imageName)
            
            
        }

    }
    
    func addChildViewController(childVcName: String, title: String, image:  String) {
        
        guard let spaceName = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else{
            print("没有取到命名空间")
            return
        }
        
        guard let childVcClass = NSClassFromString(spaceName + "." + childVcName) else{
            print("没有取到类")
            return
        }
        
        guard let childVcType = childVcClass as? UIViewController.Type else{
            return
        }
        
        let childVc = childVcType.init()
        
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: image)
        childVc.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        addChildViewController(UINavigationController(rootViewController: childVc))
        
    }
    
    

}