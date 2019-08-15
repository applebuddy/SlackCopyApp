//
//  AddChannelVC.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 13/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

/// * 채널 추가 뷰 컨트롤러
class AddChannelVC: UIViewController {
    // MARK: - Outlets

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var chanDescTextField: UITextField!
    @IBOutlet var bgView: UIView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Set Method

    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped(_:)))
        bgView.addGestureRecognizer(closeTouch)

        nameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])

        chanDescTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
    }

    // MARK: - Action Method

    @objc func closeButtonTapped(_: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - IBAction

    @IBAction func closeModelButtonPressed(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /// * createChannelButton 클릭 시 발생하는 이벤트, 채널생성 성공 시 해당 VC를 dismiss된다.
    @IBAction func createChannelButtonPressed(_: UIButton) {
        guard let channelName = nameTextField.text,
            nameTextField.text != "" else { return }
        guard let chanDesc = chanDescTextField.text,
            chanDescTextField.text != "" else { return }
        SocketService.instance.addChannel(channelName: channelName, channelDescription: chanDesc) { success in
            if success {
                // 성공 시 AddChannelViewController를 dismiss처리한다.
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
