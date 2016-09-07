//
//  TAXHomeViewCell.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/9/1.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import SDWebImage

private let picViewMargin: CGFloat = 15
private let itemMargin: CGFloat = 10

class TAXHomeViewCell: UITableViewCell {
    
    //MARK: - 控件属性
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var verifiedImageView: UIImageView!
    
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picCollectionView: UICollectionView!
    @IBOutlet weak var retweetedContentLabel: UILabel!
    @IBOutlet weak var retweetedBgView: UIView!
    @IBOutlet weak var retweetedLableCons: NSLayoutConstraint!
    @IBOutlet weak var picViewCons: NSLayoutConstraint!
    
    var viewModel: TAXStatusViewModel?{
        didSet{
            guard let viewModel = viewModel else{
                return
            }
            
            avatarImageView.sd_setImageWithURL(viewModel.avatarUrl, placeholderImage: UIImage(named: "avatar_default_small"))
            
            screenNameLabel.text = viewModel.status?.user?.screen_name
            vipImageView.image = viewModel.mbrankImage
            verifiedImageView.image = viewModel.verifiedImage
            timeLabel.text = viewModel.createAtText
            sourceLabel.text = viewModel.sourceText
            contentLabel.text = viewModel.status?.text
            
            if viewModel.status?.retweeted_status == nil {
                retweetedContentLabel.text = nil
                retweetedBgView.hidden = true
                retweetedLableCons.constant = 0
            }else{
                retweetedBgView.hidden = false
                 retweetedLableCons.constant = 10
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, text = viewModel.status?.retweeted_status?.text{
                    retweetedContentLabel.text = "@" + screenName + ": " + text
                }
                
            }
            
            
            self.screenNameLabel.textColor = viewModel.mbrankImage == nil ? UIColor.blackColor() : UIColor.orangeColor()
            
            let picViewSize = calculatePicViewSize(viewModel.picURLs.count)
            
            picViewHCons.constant = picViewSize.height
            picViewWCons.constant = picViewSize.width
            
            
            
            picCollectionView.reloadData()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 取出picView对应的layout
    }

}

//MARK: -计算图片大小

extension TAXHomeViewCell {
    private func calculatePicViewSize(count: Int) -> CGSize{
        
        if count == 0 {
            picViewCons.constant = 0
            return CGSizeZero
        }
        picViewCons.constant = 10
        
        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        if count == 1 {
            let urlString = viewModel?.picURLs.first?.absoluteString
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(urlString)
            layout.itemSize = image.size
            return image.size
        }
        
        let itemW = (UIScreen.mainScreen().bounds.width - 2 * picViewMargin - 2 * itemMargin)/3
        layout.itemSize = CGSize(width: itemW, height: itemW)
        if count == 4 {
            let picViewW = 2 * itemW + itemMargin + 0.1
            return CGSize(width: picViewW, height: picViewW)
        }
        
        let rows = CGFloat((count - 1) / 3 + 1)
        
        let picviewW = UIScreen.mainScreen().bounds.width - 2 * picViewMargin
        
        let picViewH = rows * itemW + (rows - 1) * itemMargin
        
        return CGSize(width: picviewW, height: picViewH)
        
    }
}


extension TAXHomeViewCell: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.picURLs.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCellWithReuseIdentifier("PicCell", forIndexPath: indexPath) as! TAXPicCollectionViewCell
        cell.imageUrl = viewModel?.picURLs[indexPath.row]
        return cell
    }
    
}

class TAXPicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var picImageView: UIImageView!
    
    var imageUrl : NSURL?{
        didSet{
            if let imageUrl = imageUrl {
                picImageView.sd_setImageWithURL(imageUrl, placeholderImage: UIImage(named: "empty_picture"))
            }
        }
    }
    
    override func awakeFromNib() {
        
    }
}

