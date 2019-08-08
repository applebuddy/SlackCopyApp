//
//  ProfileVC.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 08/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var bgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    @IBAction func closeModalPressed(_: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutPressed(_: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }

    func setupView() {
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor =
            UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)

        let closeTouch = UITapGestureRecognizer(target: self,
                                                action: #selector(closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }

    @objc func closeTap(_: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
