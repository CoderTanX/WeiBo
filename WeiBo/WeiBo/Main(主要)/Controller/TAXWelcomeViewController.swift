//
//  TAXWelcomeViewController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/30.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import SDWebImage
class TAXWelcomeViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  avatarImageString = TAXUserAccountViewModel.shareInstance.userAccount?.avatar_large
        
        let avatarImageUrl = NSURL(string: avatarImageString ?? "")
        
        avatarImageView.sd_setImageWithURL(avatarImageUrl, placeholderImage: UIImage(named: "avatar_default_big"))
        
        avatarConstraint.constant = UIScreen.mainScreen().bounds.size.height - 200
        
        UIView.animateWithDuration(2.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: { 
            self.view.layoutIfNeeded()
            }) { (_) in
                UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }

}
