//
//  ChatVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 19/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    @IBOutlet var menuButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    

}
