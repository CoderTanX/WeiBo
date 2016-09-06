//
//  TAXStatusViewModel.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/9/1.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXStatusViewModel: NSObject {
    
    var status : TAXStatus?
    
    ///对数据进行处理
    var sourceText: String?
    var createAtText: String?
    var verifiedImage: UIImage?
    var mbrankImage: UIImage?
    var avatarUrl : NSURL?
    var picURLs : [NSURL] = [NSURL]()
    
    
    init(status: TAXStatus) {
        self.status = status
        
        if let createdAt = status.created_at {
            createAtText = NSDate.createDateString(createdAt)
        }
        
        if let source = status.source where status.source != ""{
            let startIndex = (source as NSString).rangeOfString(">").location + 1
            let length = (source as NSString).rangeOfString("</").location - startIndex
            sourceText = (source as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
        
        let verified_type = status.user?.verified_type ?? -1
        
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            
            mbrankImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        let avatarString = status.user?.profile_image_url ?? ""
        avatarUrl = NSURL(string: avatarString)
        
        let pirURLDicts = status.pic_urls?.count == 0 ? status.retweeted_status?.pic_urls : status.pic_urls
        
        if let picURLDicts = pirURLDicts {
            for picURLDict in picURLDicts {
                
                let picURL = NSURL(string: picURLDict["thumbnail_pic"] ?? "")
                
                picURLs.append(picURL!)
            }
        }
        
        
    }
    
    
}
