//
//  ChannelVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 19/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        revealViewController()?.rearViewRevealWidth = view.frame.width - 60
    }
}
