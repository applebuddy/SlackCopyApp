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
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var typingUserLabel: UILabel!

    var isTyping = false

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        chatTableView.delegate = self
        chatTableView.dataSource = self
        messageButton.isHidden = true

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
            if success { // ChatMessage를 성공적으로 수신시 동작
                self.chatTableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.chatTableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
                }
            }
        }

        // 소켓으로부터 받아온 딕셔너리 데이터 ,typingUsers를 사용한다.
        SocketService.instance.getTypingUsers { typingUsers in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name, channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }

            // 최소 한 명 이상이 타이핑 중이고, 로그인상태라면,
            if numberOfTypers > 0, AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 { // 다수가 타이핑 중이면 is -> are 로 동사 변경
                    verb = "are"
                }
                self.typingUserLabel.text = "\(names) \(verb) typing a message"
            } else { // 아무도 타이핑을 안하고나 로그인상태가 아니라면,
                self.typingUserLabel.text = ""
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
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
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
            // 유저 데이터가 없을 시 로그인 요청 문구 표시 및 채팅창 테이블 뷰 갱신
            channelNameLabel.text = "Please Log In"
            chatTableView.reloadData()
        }
    }

    @objc func handleTap() {
        view.endEditing(true)
    }

    @IBAction func messageFieldEditing(_: UITextField) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        if messageTextField.text == "" {
            isTyping = false
            messageButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
                messageButton.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }

    @IBAction func messageButtonPressed(_: UIButton) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTextField.text else { return }

            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { success in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.id, channelId)
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
