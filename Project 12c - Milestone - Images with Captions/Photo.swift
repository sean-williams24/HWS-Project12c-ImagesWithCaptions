//
//  Photo.swift
//  Project 12c - Milestone - Images with Captions
//
//  Created by Sean Williams on 18/10/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit

class Photo: NSObject {
    let image: UIImage
    let caption: String
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    }
    
}
