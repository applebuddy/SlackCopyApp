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
    @IBOutlet var messageBodyLabel: UILabel!
    @IBOutlet var timeStampLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message) {
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImageView.image = UIImage(named: message.userAvatar)
        userImageView.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)

        // 2017-07-13T21:49:25.5902
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = String(isoDate.suffix(from: end))

        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))

        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d. h:mm a"

        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLabel.text = finalDate
        }
    }
}
