//
//  CommentTableViewCell.swift
//  Parstagram
//
//  Created by Kevin Denis on 11/22/19.
//  Copyright © 2019 Kevin Denis. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var CommentAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
