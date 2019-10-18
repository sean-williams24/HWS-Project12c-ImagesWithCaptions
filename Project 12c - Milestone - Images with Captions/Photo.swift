//
//  Photo.swift
//  Project 12c - Milestone - Images with Captions
//
//  Created by Sean Williams on 18/10/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit

class Photo: NSObject, Codable {
    var imageName: String
    var caption: String
    
    init(imageName: String, caption: String) {
        self.imageName = imageName
        self.caption = caption
    }
    
}
