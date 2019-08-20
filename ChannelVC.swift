//
//  ChannelVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 19/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

/// * Smack 채널 뷰 컨트롤러
class ChannelVC: UIViewController {
    // MARK: - IBOutlet

    @IBOutlet var channelTableView: UITableView!

    @IBOutlet var loginButton: UIButton!

    @IBOutlet var userImageView: CircleImageView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        revealViewController()?.rearViewRevealWidth = view.frame.width - 60

        channelTableView.delegate = self
        channelTableView.dataSource = self
        SocketService.instance.getChannel { success in
            if success {
                self.channelTableView.reloadData()
            }
        }
        setupUserInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIFI_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
    }

    // MARK: - Set Method

    // 로그인 상태에 따라서 UI 상태를 설정한다.
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImageView.image = UIImage(named: UserDataService.instance.avatarName)
            userImageView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImageView.image = UIImage(named: "menuProfileIcon")
            userImageView.backgroundColor = .clear
            channelTableView.reloadData()
        }
    }

    // MARK: - Action Method

    @objc func userDataDidChange(_: Notification) {
        setupUserInfo()
    }

    @objc func channelsLoaded(_: Notification) {
        channelTableView.reloadData()
    }

    // MARK: - IBAction

    @IBAction func loginButtonPressed(_: UIButton) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }

    @IBAction func addChannelButtonPressed(_: UIButton) {
        // 로그인이 되어있다면, 채널 추가 시도
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }

    // ChannelViewControler 로 Unwind하는 메서드
    @IBAction func prepareForUnwind(segue _: UIStoryboardSegue) {
        print("UNWIND")
    }
}

extension ChannelVC: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택한 채널에 대한 데이터 처리한다.
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNELS_SELECTED, object: nil)

        revealViewController()?.revealToggle(animated: true)
    }

    func tableView(_: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
}

extension ChannelVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelTableViewCell else { return UITableViewCell() }

        // 채널 데이터를 준비한다.
        let channel = MessageService.instance.channels[indexPath.row]

        // 셀에 채널 데이터를 적용한다.
        cell.configureCell(channel: channel)

        return cell
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return MessageService.instance.channels.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
