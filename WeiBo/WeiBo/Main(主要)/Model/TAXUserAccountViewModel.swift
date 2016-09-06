//
//  TAXUserAccountViewModel.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/30.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXUserAccountViewModel {
    
    static let shareInstance : TAXUserAccountViewModel = TAXUserAccountViewModel()
    
    var accountPath: String {
        
        let accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        print(accountPath)
        return (accountPath as NSString).stringByAppendingString("/account.plish")
        
    }
    
    var userAccount: TAXUserAccount?
    
    var isLogin: Bool{
        if let userAccount = userAccount  {
            if let expires_date = userAccount.expires_date {
                return expires_date.compare(NSDate()) == NSComparisonResult.OrderedDescending
            }
        }
        return false
    }
    
    init(){
        userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? TAXUserAccount
        
    }
}
