//
//  AddChannelVC.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 13/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    // MARK: - Outlets

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var chanDescTextField: UITextField!
    @IBOutlet var bgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped(_:)))
        bgView.addGestureRecognizer(closeTouch)

        nameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])

        chanDescTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
    }

    @IBAction func closeModelButtonPressed(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createChannelButtonPressed(_: UIButton) {}

    @objc func closeButtonTapped(_: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
