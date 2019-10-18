//
//  PhotoCell.swift
//  Project 12c - Milestone - Images with Captions
//
//  Created by Sean Williams on 18/10/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
