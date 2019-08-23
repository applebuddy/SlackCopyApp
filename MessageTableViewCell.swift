//
//  MessageTableViewCell.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 23/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet var userImageView: CircleImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var timeStampLabel: NSLayoutConstraint!
    @IBOutlet var messageBodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message) {
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImageView.image = UIImage(named: message.userAvatar)
        userImageView.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
}
