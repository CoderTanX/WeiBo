//
//  NetworkTools.swift
//  19-Swift-AFNetworking的封装
//
//  Created by 谭安溪 on 16/8/29.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import AFNetworking

enum MethodType {
    case GET
    case POST
}

class NetworkTools: AFHTTPSessionManager {
    static let shareInstance: NetworkTools = {
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
}
//MARK: - 封装请求方法
extension NetworkTools {
    
    func request(methodType: MethodType ,urlString: String, parameters: [String : AnyObject], finished: (result: AnyObject?, error: NSError?) -> ()){
        
         // 1.定义成功的回调闭包
        let success = { (task: NSURLSessionDataTask, result: AnyObject?) in
            finished(result: result, error: nil)
        }
        // 2.定义失败的回调闭包
        let failure = { (task: NSURLSessionDataTask?, error: NSError) in
            finished(result: nil, error: error)
        }
        // 3.发送网络请求
        if methodType == .GET {
            
            GET(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            
            POST(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    
}
//MARK: - 请求AccessToken

extension NetworkTools {
    
    func loadAccessToken(code: String, finished: (result: [String: AnyObject]?,error: NSError?)->()){
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let params = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        
        request(.POST, urlString: urlString, parameters: params) { (result, error) in
            finished(result: result as? [String: AnyObject],error: error)
        }
    }
}

//MARK: - 请求用户信息

extension NetworkTools {
    
    func loadUserInfo(accessToken: String, uid: String, finished:(result: [String: AnyObject]?, error: NSError?)->()){
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let params = ["access_token":accessToken,"uid": uid]
        
        
        request(.GET, urlString: urlString, parameters: params) { (result, error) in
            finished(result: result as? [String: AnyObject], error: error)
        }
    }
}

//MARK: - 请求首页数据

extension NetworkTools {
    func loadStatuses(finished: (result: [[String: AnyObject]]?, error: NSError?) -> ()){
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let params = ["access_token": (TAXUserAccountViewModel.shareInstance.userAccount?.access_token)!]
        
        request(.GET, urlString: urlString, parameters: params) { (result, error) in
            
            guard let resultDict = result as? [String: AnyObject] else{
                return
            }
            
            finished(result: resultDict["statuses"] as? [[String : AnyObject]], error: error)
            
        }
        
    }
}





