//
//  ViewController.swift
//  CPTinder
//
//  Created by Josiah Gaskin on 6/3/15.
//  Copyright (c) 2015 CodePathLab. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet var cardView: DraggableImageView!
    
    var cardInitialCenter : CGPoint!
    var isPresenting: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.image = UIImage(named: "ryan")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapImage(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("show_profile", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! ProfileViewController
        controller.modalPresentationStyle = UIModalPresentationStyle.Custom
        controller.transitioningDelegate = self
        controller.image = cardView.image
    }
    

    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            cardInitialCenter = cardView.center
        case .Changed, .Ended, .Cancelled:
            cardView.center = CGPointMake(cardInitialCenter.x + sender.translationInView(view).x, cardInitialCenter.y + sender.translationInView(view).y)
            cardView.setNeedsLayout()
        default:
            return
        }
    }
}

extension CardsViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
}


extension CardsViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var cloneImageView = UIImageView(frame: cardView.frame)
        cloneImageView.image = cardView.image
        cloneImageView.center = cardView.center
        cloneImageView.clipsToBounds = true

        containerView.addSubview(cloneImageView)
    
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }


}