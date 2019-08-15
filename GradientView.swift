//
//  GradientView.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 20/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

@IBDesignable
/// * Smack앱 그레디언트 배경뷰
class GradientView: UIView {
    // MARK: - Property

    // IBInspectable : Interface Builder에서 커스텀 할 수 있는 옵션 추가
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.287455678, green: 0.3025078475, blue: 0.8791555762, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }

    // MARK: - View Cycle Method

    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
