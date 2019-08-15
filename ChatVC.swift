//
//  ChatVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 19/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

/// * Smack 채팅 뷰 컨트롤러
class ChatVC: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var menuButton: UIButton!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

        // SWRevealViewController Event Recognizer
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())

        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { _ in
                NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
            }
        }

        MessageService.instance.findAllChannel { _ in
        }
    }
}
