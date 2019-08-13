//
//  ChannelVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 19/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var channelTableView: UITableView!

    @IBOutlet var loginButton: UIButton!

    @IBOutlet var userImageView: CircleImageView!

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
    }

    @IBAction func loginButtonPressed(_: UIButton) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }

    @IBAction func prepareForUnwind(segue _: UIStoryboardSegue) {
        print("UNWIND")
    }

    @objc func userDataDidChange(_: Notification) {
        setupUserInfo()
    }

    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImageView.image = UIImage(named: UserDataService.instance.avatarName)
            userImageView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImageView.image = UIImage(named: "menuProfileIcon")
            userImageView.backgroundColor = .clear
        }
    }

    // MARK: - DataSource

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

    @IBAction func addChannelButtonPressed(_: UIButton) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
}
