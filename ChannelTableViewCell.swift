//
//  ChannelTableViewCell.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 13/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {
    @IBOutlet var channelNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    // 셀 설정 메서드
    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        channelNameLabel.text = "#\(title)"
    }
}
