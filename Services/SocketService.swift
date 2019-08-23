//
//  SocketService.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 13/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import SocketIO
import UIKit

/// * 소켓 서비스 싱글턴 클래스
class SocketService: NSObject {
    static let instance = SocketService()

    let manager: SocketManager
    let socket: SocketIOClient

    override init() {
        manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        socket = manager.defaultSocket

        super.init()
    }

    /// * 소켓 연결을 시작한다.
    func establishConnection() {
        socket.connect()
    }

    /// * 소켓 연결을 종료한다.
    func closeConnection() {
        socket.disconnect()
    }

    /// * 소켓을 사용하여 채널을 생성시도한다.
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }

    /// * 소켓을 사용하여 채널정보를 흭득시도한다.
    func getChannel(completion: @escaping CompletionHandler) {
        //  Socket Code... io.emit("channelCreated", channel.name, channel.description, channel.id);
        socket.on("channelCreated") { dataArray, _ in
            // 채널이름, 설명, 아이디를 받아 채널정보를 흭득 시도한다.
            guard let channelName = dataArray[0] as? String,
                let channelDesc = dataArray[1] as? String,
                let channelId = dataArray[2] as? String else {
                completion(false)
                return
            }

            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }

    // 메세지 추가 메서드
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }

    // MARK: getCheckMessage

    // in socket...
    // * io.emit("messageCreated",  msg.messageBody, msg.userId, msg.channelId, msg.userName, msg.userAvatar, msg.userAvatarColor, msg.id, msg.timeStamp);
    func getChatMessage(completion: @escaping CompletionHandler) {
        socket.on("messageCreated") { dataArray, _ in
            // 채널 메세지 관련 데이터를 준비한다.
            guard let messageBody = dataArray[0] as? String,
                let channelId = dataArray[2] as? String,
                let userName = dataArray[3] as? String,
                let userAvatar = dataArray[4] as? String,
                let userAvatarColor = dataArray[5] as? String,
                let id = dataArray[6] as? String,
                let timeStamp = dataArray[7] as? String else { return }

            // 선택 된 채널의 아이디와 일치하고, 로그인 되어있다면, 메세지를 생성한다.
            if channelId == MessageService.instance.selectedChannel?.id, AuthService.instance.isLoggedIn {
                let newMessage = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
