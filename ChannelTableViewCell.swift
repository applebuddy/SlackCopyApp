//
//  ChannelTableViewCell.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 13/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet var channelNameLabel: UILabel!

    // MARK: - Init

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    // MARK: - Set Method

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
        let title = channel.name ?? ""
        channelNameLabel.text = "#\(title)"
        channelNameLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)

        // 만약 안읽은 메세지 이면 추가적인 표시를 한다.
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelNameLabel.font = UIFont(name: "HelvelticaNeue-Bold", size: 22)
            }
        }
    }
}
