//
//  ViewController.swift
//  CPTinder
//
//  Created by Josiah Gaskin on 6/3/15.
//  Copyright (c) 2015 CodePathLab. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet var cardView: DraggableImageView!
    
    var cardInitialCenter : CGPoint!
    
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

