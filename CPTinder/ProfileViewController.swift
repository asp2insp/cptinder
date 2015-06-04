//
//  ProfileViewController.swift
//  CPTinder
//
//  Created by Josiah Gaskin on 6/3/15.
//  Copyright (c) 2015 CodePathLab. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var image : UIImage? {
        didSet {
            if profileImage != nil {
                profileImage.image = image
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        profileImage.image = self.image
    }

}