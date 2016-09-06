//
//  TAXPopoverAnimator.swift
//  WeiBo
//
//  Created by 谭安溪 on 16/8/25.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class TAXPopoverAnimator: NSObject{
    private var isPresented : Bool = false
    var presentedViewFrame : CGRect = CGRectZero
    //回调函数
    var callBack : ((presented : Bool) -> ())?
    
    init(callBack: (presented : Bool) -> ()) {
        self.callBack = callBack
    }
    
    override init() {
        super.init()
    }
    
    
}

// MARK:- 自定义转场代理的方法
extension TAXPopoverAnimator: UIViewControllerTransitioningDelegate{
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let presentationController = TAXPresentationController(presentedViewController: presented, presentingViewController: presenting)
        presentationController.presentedViewFrame = presentedViewFrame
        
        return presentationController
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
    
}
// MARK:- 弹出和消失动画代理的方法
extension TAXPopoverAnimator: UIViewControllerAnimatedTransitioning{
    
    //动画的时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        callBack!(presented : isPresented)
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissView(transitionContext)
    }
    ///弹出动画
    private func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning){
        
        let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        transitionContext.containerView()?.addSubview(presentedView)
        
        presentedView.transform = CGAffineTransformMakeScale(1.0, 0.0)
        
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            presentedView.transform = CGAffineTransformIdentity
        }) { (_) in
            transitionContext.completeTransition(true)
            
        }
        
    }
    
    ///消失动画
    private func animationForDismissView(transitionContext: UIViewControllerContextTransitioning){
        
        let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            dismissView?.transform = CGAffineTransformMakeScale(1.0, 0.00001)
        }) { (_) in
            dismissView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
    
    
}