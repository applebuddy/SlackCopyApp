//
//  ChatViewController.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 19/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

/// * Smack 채팅 뷰 컨트롤러
class ChatViewController: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var menuButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var channelNameLabel: UILabel!
    @IBOutlet var chatTableView: UITableView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        chatTableView.delegate = self
        chatTableView.dataSource = self

        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        view.addGestureRecognizer(tap)
        menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

        // SWRevealViewController Event Recognizer
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())

        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataDidChange(_:)), name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)

        SocketService.instance.getChatMessage { success in
            if success {
                self.chatTableView.reloadData()
            }
        }

        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { _ in
                NotificationCenter.default.post(name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
            }
        }

        MessageService.instance.findAllChannel { _ in
        }
    }

    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { success in
            if success {
                if MessageService.instance.channels.count > 0 {
                    // 선택 된 채널은 1개 이상 존재 시 맨 첫번째 채널
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    // 아직 생성한 채널이 없을때 라벨 표시 설정
                    self.channelNameLabel.text = "No channels yet"
                }
            }
        }
    }

    @objc func channelSelected(_: Notification) {
        updateWithChannel()
    }

    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }

    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { success in
            if success {
                self.chatTableView.reloadData()
            }
        }
    }

    // 유저 데이터가 변경될 시 호출 메서드
    @objc func userDataDidChange(_: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            // 유저 데이터가 없을 시 로그인 요청 문구 표시
            channelNameLabel.text = "Please Log In"
        }
    }

    @objc func handleTap() {
        view.endEditing(true)
    }

    @IBAction func messageButtonPressed(_: UIButton) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTextField.text else { return }

            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { success in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return MessageService.instance.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: messageTableViewCell, for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        let message = MessageService.instance.messages[indexPath.row]
        cell.configureCell(message: message)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
