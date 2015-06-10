//
//  UserCell.swift
//  koen-BitDate
//
//  Created by Koen Hendriks on 09/06/15.
//  Copyright (c) 2015 Koen Hendriks. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

	
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
		avatarImageView.layer.masksToBounds = true
	}

}
