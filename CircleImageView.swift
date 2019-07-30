//
//  CircleImageView.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 30/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {
    override func awakeFromNib() {
        setUpView()
    }

    func setUpView() {
        layer.cornerRadius = frame.width / 2 // 테두리를 둥글게 만든다.
        clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}
