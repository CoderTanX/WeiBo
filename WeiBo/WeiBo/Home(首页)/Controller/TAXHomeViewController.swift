//
//  TAXHomeViewController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import SDWebImage

class TAXHomeViewController: TAXBaseViewController {
    
    private lazy var titleBtn : TAXTitleBtn = TAXTitleBtn()
    
    private lazy var popverAnimator : TAXPopoverAnimator = TAXPopoverAnimator { (presented) in
        self.titleBtn.selected = presented
    }
    ///数据源
    private lazy var viewModels : [TAXStatusViewModel] = Array()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard isLogin else{
            //没有登录的话就直接返回
            vistorView.addRotationAnim()
            return
        }
        
        setupNavigationBar()
        
        //请求数据
        loadStatuses()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }

}
//MARK: - 构建UI界面
extension TAXHomeViewController {
    ///初始化呢NavigationBar
    private func setupNavigationBar(){
        //设置item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        //设置titleView
        titleBtn.setTitle("fall out boy", forState: .Normal)
        titleBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        navigationItem.titleView = titleBtn
        
        //添加点击事件
        titleBtn.addTarget(self, action: #selector(titleBtnClick), forControlEvents: .TouchUpInside)
    }
}

extension TAXHomeViewController {
    
    @objc private func titleBtnClick(){
        
        
        popverAnimator.presentedViewFrame =  CGRect(x: 100, y: 55, width: 180, height: 250)
            
        
        let popoverVc = TAXPopoverViewController()
        popoverVc.modalPresentationStyle = .Custom
        
        //设置代理
        popoverVc.transitioningDelegate = popverAnimator
        
        presentViewController(popoverVc, animated: true, completion: nil)
    }
    
}
//MARK: - 网络请求
extension TAXHomeViewController {
    ///请求数据
    private func loadStatuses(){
        NetworkTools.shareInstance.loadStatuses { (result, error) in
            if error != nil{
                print(error)
                return
            }
            
            guard let result = result else{
                return
            }
            
            for dict in result{
                
                let status = TAXStatus(dict: dict)
                let viewModel = TAXStatusViewModel(status: status)
                self.viewModels.append(viewModel)
            }
            self.cacheImages(self.viewModels)
        }
    
    }
    
    private func cacheImages(viewModels:[TAXStatusViewModel]){
        
        let groud = dispatch_group_create()
        
        for viewModel in viewModels {
            for picURL in viewModel.picURLs {
                dispatch_group_enter(groud)
                SDWebImageManager.sharedManager().downloadImageWithURL(picURL, options: [], progress: nil, completed: { (_, _, _, _, _) in
//                    print("下载了一张图片")
                    dispatch_group_leave(groud)
                })
            }
        }
        
        dispatch_group_notify(groud, dispatch_get_main_queue()) { 
//            print("刷新表格")
            self.tableView.reloadData();
        }
    }
    
    
}

//MARK: - tableView数据源，和代理方法
extension TAXHomeViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! TAXHomeViewCell
        cell.viewModel = viewModels[indexPath.row]
        return cell
    }
    
}






