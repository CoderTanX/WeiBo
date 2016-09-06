//
//  TAXStatus.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/31.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXStatus: NSObject {
    
    // MARK:- 属性
    var created_at : String?                // 微博创建时间
    var source : String?                    // 微博来源
    var text : String?                      // 微博的正文
    var mid : Int = 0                       // 微博的ID
    var user : TAXUser?
    var pic_urls : [[String: String]]?      // 图片数组
    var retweeted_status: TAXStatus?
    
    
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        if let userDict = dict["user"] as? [String: AnyObject]{
            user = TAXUser(dict: userDict)
        }
        
        if let retweetedStatusDic = dict["retweeted_status"] as? [String: AnyObject] {
             retweeted_status = TAXStatus(dict: retweetedStatusDic)
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }
    
}
