//
//  AvatarCollectionViewCell.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 30/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

// MARK: - Avatar Image Type

enum AvatarType {
    case dark
    case light
}

/// * Avatar 이미지 선택 셀
class AvatarCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet

    @IBOutlet var avatarImageView: UIImageView!

    // MARK: - Init

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    // MARK: - Set Method

    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImageView.image = UIImage(named: "dark\(index)")
            layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImageView.image = UIImage(named: "light\(index)")
            layer.backgroundColor = UIColor.gray.cgColor
        }
    }

    func setUpView() {
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
