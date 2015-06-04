//
//  DraggableImageView.swift
//  CPTinder
//
//  Created by Francisco de la Pena on 6/3/15.
//  Copyright (c) 2015 CodePathLab. All rights reserved.
//

import UIKit

class DraggableImageView: UIView {

    @IBOutlet var draggableImageView: UIImageView!
    
    var image: UIImage! {
        didSet {
            draggableImageView.image = image
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        draggableImageView.frame = bounds
        addSubview(draggableImageView)
        draggableImageView.layer.cornerRadius = 20

        
        
    }
}

