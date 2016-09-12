//
//  TAXComposeViewController.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/9/7.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let picPickerViewId = "picPickerView"

private let itemMargin: CGFloat = 15

class TAXComposeViewController: UIViewController {

    private lazy var titleView: UIView = TAXComposeTitleView()
    @IBOutlet weak var composeTextView: TAXComposeTextView!
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var picPickerView: UICollectionView!
    
    @IBOutlet weak var picPickerViewHCons: NSLayoutConstraint!
    
    private lazy var images : [UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置NavigationBar
        setupNavigationBar()
        
        //设置setupPicPickerView
        setupPicPickerView()
        
        //监听键盘弹出通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        composeTextView.becomeFirstResponder()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
//MARK: - 设置UI界面
extension TAXComposeViewController {
    
    ///设置NavigationBar
    private func setupNavigationBar(){
        self.title = "发布";
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: #selector(cancelClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分享", style: .Plain, target: self, action: #selector(shareClick))
        navigationItem.rightBarButtonItem?.enabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        navigationItem.titleView = titleView
    }
    
    private func setupPicPickerView(){
        
        picPickerView.registerNib(UINib(nibName: "TAXPicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: picPickerViewId)
        
        let layout = picPickerView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemHW = (UIScreen.mainScreen().bounds.width - 4 * itemMargin)/3
        
        layout.itemSize = CGSize(width: itemHW, height: itemHW)
        
        layout.minimumLineSpacing = itemMargin
        
        layout.minimumInteritemSpacing = itemMargin
        
        picPickerView.contentInset = UIEdgeInsetsMake(itemMargin, itemMargin, 0, itemMargin)
        
    }
    
}

//MARK: - 监听事件

extension TAXComposeViewController {
    
    @objc private func cancelClick(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func shareClick(){
        print("shareClick")
    }
    
    @objc private func keyboardWillChangeFrame(note: NSNotification){
//        print(note.userInfo)
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let margin = UIScreen.mainScreen().bounds.height - endFrame.origin.y
        toolBarBottomCons.constant = margin
        UIView.animateWithDuration(duration) { 
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func picPickerBtnClick() {
        //退出键盘
        composeTextView.resignFirstResponder()
        
        picPickerViewHCons.constant = UIScreen.mainScreen().bounds.height * 0.65
        
        UIView.animateWithDuration(0.5) {
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    
}

//MARK: - textView的代理
extension TAXComposeViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        
        composeTextView.placeHolderLabel.hidden = textView.hasText()
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        composeTextView.resignFirstResponder()
    }
}

//MARK: - collectionView的代理
extension TAXComposeViewController: UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCellWithReuseIdentifier(picPickerViewId, forIndexPath: indexPath) as! TAXPicPickerViewCell
        cell.delegate = self
        cell.backgroundColor = UIColor.redColor()
        cell.image = indexPath.row < images.count ? images[indexPath.item] : nil
        return cell
    }
}
//MARK: - TAXPicPickerViewCell代理方法
extension TAXComposeViewController: TAXPicPickerViewCellDelegate{
    
    func didSelectedPicBtn(collectionViewCell: UICollectionViewCell) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) else{
            return
        }
        
        let ipc = UIImagePickerController()
        ipc.delegate = self
        ipc.sourceType = .PhotoLibrary
        presentViewController(ipc, animated: true, completion: nil)
        
        
    }
    
    func didSelectedRemoveBtn(collectionViewCell: UICollectionViewCell) {
        
        let item = picPickerView.indexPathForCell(collectionViewCell)?.item
        
        if let item = item {
            images.removeAtIndex(item)
            picPickerView.reloadData()
        }
        
    }
}

extension TAXComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        images.append(image)
        
        picPickerView.reloadData()
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}



















