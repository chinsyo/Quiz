//
//  PresentingAnimator.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import UIKit

class PresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: .from)
        fromView?.tintAdjustmentMode = .dimmed
        fromView?.isUserInteractionEnabled = false
        
        let dimmingView = UIView(frame: containerView.frame)
        dimmingView.backgroundColor = Constant.Color.black
        dimmingView.alpha = 0
        
        let toView = transitionContext.viewController(forKey: .to)?.view
        
        containerView.addSubview(dimmingView)
        containerView.addSubview(toView!)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            dimmingView.alpha = 0.5
            
            toView?.snp.makeConstraints { maker in

                maker.centerX.centerY.equalToSuperview()
                maker.width.equalToSuperview().inset(50)
                maker.height.equalTo(220)
            }
            
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
