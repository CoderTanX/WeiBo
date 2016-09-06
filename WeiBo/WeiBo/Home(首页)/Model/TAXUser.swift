//
//  TAXUser.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/9/1.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXUser: NSObject {
    // MARK:- 属性
    var profile_image_url : String?         // 用户的头像
    var screen_name : String?               // 用户的昵称
    var verified_type : Int = -1            // 用户的认证类型

    var mbrank : Int = 0 // 用户的会员等级
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}
