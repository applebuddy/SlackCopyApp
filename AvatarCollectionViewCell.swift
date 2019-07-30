//
//  AvatarCollectionViewCell.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 30/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
    @IBOutlet var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView() {
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
