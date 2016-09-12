//
//  TAXPicPickerViewCell.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/9/12.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

@objc protocol TAXPicPickerViewCellDelegate {

    optional func didSelectedPicBtn(collectionViewCell: UICollectionViewCell)
    optional func didSelectedRemoveBtn(collectionViewCell: UICollectionViewCell)
}
class TAXPicPickerViewCell: UICollectionViewCell {

    var delegate : TAXPicPickerViewCellDelegate?
    
    @IBOutlet weak var picBtn: UIButton!
     @IBOutlet weak var removeBtn: UIButton!
    var image : UIImage?{

        didSet{
            if image == nil {
                picBtn.setBackgroundImage(UIImage(named: "compose_pic_add"), forState: .Normal)
                picBtn.userInteractionEnabled = true
                removeBtn.hidden = true
            }else{
                picBtn.setBackgroundImage(image, forState: .Normal)
                picBtn.userInteractionEnabled = false
                removeBtn.hidden = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension TAXPicPickerViewCell {
    
    @IBAction func picBtnClick(sender: UIButton) {
        self.delegate?.didSelectedPicBtn?(self)
    }
    
    @IBAction func removeBtnClick() {
        self.delegate?.didSelectedRemoveBtn?(self)
    }
    
}
