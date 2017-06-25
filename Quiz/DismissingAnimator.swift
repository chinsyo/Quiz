//
//  DismissAnimator.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import UIKit

class DismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let toController = transitionContext.viewController(forKey: .to)
        toController?.view.tintAdjustmentMode = .normal
        toController?.view.isUserInteractionEnabled = true
        
        let fromView = transitionContext.viewController(forKey: .from)?.view
        
        var dimmingView: UIView!
        for subview in containerView.subviews {
            if subview.layer.opacity < 1.0 {
                dimmingView = subview
                break
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: { 
            fromView?.layer.transform = CATransform3DMakeScale(0, 0, 1)
            dimmingView.alpha = 0
        }) { finished in
            dimmingView.removeFromSuperview()
            fromView?.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
    }
}
