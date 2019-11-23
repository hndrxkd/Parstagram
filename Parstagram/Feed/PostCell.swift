//
//  PostCell.swift
//  Parstagram
//
//  Created by Kevin Denis on 11/15/19.
//  Copyright © 2019 Kevin Denis. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postPicView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
