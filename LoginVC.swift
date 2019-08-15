//
//  LoginVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 20/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

/// * 로그인 창 뷰 컨트롤러
class LoginVC: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var spinner: UIActivityIndicatorView!

    // MARK: - Property

    var isCreate: Bool {
        get {
            return spinner.isHidden == false
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

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    // MARK: - Set Method

    func setupView() {
        isCreate = false

        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
    }

    // MARK: - IBAction

    @IBAction func loginPressed(_: UIButton) {
        isCreate = true

        guard let email = usernameTextField.text, email != "" else {
            return
        }

        guard let password = passwordTextField.text, password != "" else { return }

        AuthService.instance.loginUser(email: email, password: password) { success in
            if success {
                AuthService.instance.findUserByEmail(completion: { success in
                    if success {
                        NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
                        self.isCreate = false
                        self.dismiss(animated: true, completion: nil)
                    }

                })
            }
        }
    }

    @IBAction func closeButtonPressed(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createAccountButtonPressed(_: UIButton) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
}
