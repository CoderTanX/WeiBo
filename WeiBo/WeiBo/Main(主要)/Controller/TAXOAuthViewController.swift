//
//  TAXOAuthViewController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/29.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAXOAuthViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UINavigationBar
        setupNavigationBar()
        
        //加载网页
        loadPage()
       
    }

}
//MARK: - 设置界面
extension TAXOAuthViewController {
    ///设置UINavigationBar
    private func setupNavigationBar(){
        title = "登录"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(cancelItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .Plain, target: self, action: #selector(fillItemClick))
    }
    
    private func loadPage(){
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        guard let url = NSURL(string: urlString) else{
            return
        }
        
        let request = NSURLRequest(URL: url)
        
        webView.loadRequest(request)
        
        
    }
    
}
//MARK: - 监听事件点击
extension TAXOAuthViewController {
    @objc private func cancelItemClick(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    @objc private func fillItemClick(){
        
         let jsCode = "document.getElementById('userId').value='1606020376@qq.com';document.getElementById('passwd').value='haomage';"
        webView.stringByEvaluatingJavaScriptFromString(jsCode)
    }
    
}
//MARK: - UIWebViewDelegate
extension TAXOAuthViewController: UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.URL else{
            return true
        }
        
        let urlString = url.absoluteString
        
        guard urlString.containsString("code=") else{
            return true
        }
        
        let code = urlString.componentsSeparatedByString("code=").last!
        
        loadAccessToken(code)
        
        
        return false
        
    }
}

extension TAXOAuthViewController {
    ///请求token
    private func loadAccessToken(code: String){
        NetworkTools.shareInstance.loadAccessToken(code) { (result, error) in
            if error != nil {
                print(error)
                return
            }
            
//            print(result)
            guard let accountDict = result else{
                print("没有获取到用户信息")
                return
            }
            
            let userAccount = TAXUserAccount(dict: accountDict)
            
            self.loadUserInfo(userAccount)
            
        }
    }
    
    ///请求用户信息
    
    private func loadUserInfo(userAccount: TAXUserAccount){
        
        guard let access_token = userAccount.access_token else{
            return
        }
        
        guard let uid = userAccount.uid else {
            return
        }
        
        NetworkTools.shareInstance.loadUserInfo(access_token, uid: uid) { (result, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            guard let userInfoDict = result else{
                
                return
            }
            
            userAccount.screen_name = userInfoDict["screen_name"] as? String
            userAccount.avatar_large  = userInfoDict["avatar_large"] as? String
//            print(userAccount)
            //使用归档将将用户存起来
//            var accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
//            accountPath = (accountPath as NSString).stringByAppendingString("/account.plish")
//            print(accountPath)
            NSKeyedArchiver.archiveRootObject(userAccount, toFile: TAXUserAccountViewModel.shareInstance.accountPath)
            
            TAXUserAccountViewModel.shareInstance.userAccount = userAccount
            
            self.dismissViewControllerAnimated(false, completion: {
                UIApplication.sharedApplication().keyWindow?.rootViewController = TAXWelcomeViewController()
            })
            
        }
    }
}







