//
//  CreateAccountVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 20/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import Alamofire
import UIKit

class CreateAccountVC: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var userImageView: UIImageView!

    // Variables
    var avatarName = "profileDefault" // 디폴트 아바타 이름
    var avatarColor = "[0.5, 0.5, 0.5, 1]"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_: Bool) {
        super.viewDidAppear(true)
        if UserDataService.instance.avatarName != "" {
            userImageView.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }

    @IBAction func createAccountPressed(_: UIButton) {
        guard let name = userNameTextField.text, userNameTextField.text != "" else { return }
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }

        AuthService.instance.registerUser(email: email, password: password) { success in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { success in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { success in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }

    @IBAction func pickAvatarPressed(_: UIButton) {
        performSegue(withIdentifier: To_AVATAR_PICKER, sender: nil)
    }

    @IBAction func pickBGColorPressed(_: UIButton) {}

    @IBAction func closeButtonPressed(_: UIButton) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}
