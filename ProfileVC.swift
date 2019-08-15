//
//  ProfileVC.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 08/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

/// * 현재 로그인한 유저 정보 뷰 컨트롤러
class ProfileVC: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var bgView: UIView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Set Method

    func setupView() {
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor =
            UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)

        let closeTouch = UITapGestureRecognizer(target: self,
                                                action: #selector(closeButtonTapped(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }

    // MARK: - Action Method

    @objc func closeButtonTapped(_: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - IBAction

    @IBAction func closeModalPressed(_: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutPressed(_: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
}
