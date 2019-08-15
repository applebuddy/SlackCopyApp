//
//  CreateAccountVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 20/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import Alamofire
import UIKit

/// * 회원가입 뷰 컨트롤러
class CreateAccountVC: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!

    // MARK: - Property

    var isSpinnerHidden: Bool {
        get {
            return spinner.isHidden
        }
        set {
            if newValue {
                spinner.isHidden = false
                spinner.startAnimating()
            } else {
                spinner.stopAnimating()
                spinner.isHidden = true
            }
        }
    }

    var avatarName = "profileDefault" // 디폴트 아바타 이름
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override func viewDidAppear(_: Bool) {
        super.viewDidAppear(true)
        if UserDataService.instance.avatarName != "" {
            userImageView.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light"), bgColor == nil {
                userImageView.backgroundColor = UIColor.lightGray
            }
        }
    }

    // MARK: - Set Method

    func setUpView() {
        spinner.isHidden = true
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])

        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapEvent))
        view.addGestureRecognizer(viewTapGesture)
    }

    // MARK: - Action Method

    @objc func handleTapEvent() {
        view.endEditing(true)
    }

    // MARK: - IBAction

    /// * 계정 만들기 버튼 클릭 이벤트 메서드
    @IBAction func createAccountPressed(_: UIButton) {
        isSpinnerHidden = true
        guard let name = userNameTextField.text, userNameTextField.text != "" else { return }
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }

        AuthService.instance.registerUser(email: email, password: password) { success in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { success in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { success in
                            if success {
                                self.isSpinnerHidden = false
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)

                                // * 유저 데이터가 변경되었음을 감지하여 노티피케이션을 전송한다.
                                NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }

    @IBAction func pickAvatarPressed(_: UIButton) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }

    @IBAction func pickBGColorPressed(_: UIButton) {
        let red = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255

        bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)

        UIView.animate(withDuration: 0.2) { // 아바타 배경색 변경 애니메이션
            self.userImageView.backgroundColor = self.bgColor
        }
    }

    @IBAction func closeButtonPressed(_: UIButton) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}
