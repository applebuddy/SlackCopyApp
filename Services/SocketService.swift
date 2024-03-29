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
                let description = dataArray[1] as? String,
                let channelId = dataArray[2] as? String else {
                completion(false)
                return
            }

            let newChannel = Channel(_id: channelId, name: channelName, description: description)
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
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void) {
        socket.on("messageCreated") { dataArray, _ in
            // 채널 메세지 관련 데이터를 준비한다.
            guard let messageBody = dataArray[0] as? String,
                let channelId = dataArray[2] as? String,
                let userName = dataArray[3] as? String,
                let userAvatar = dataArray[4] as? String,
                let userAvatarColor = dataArray[5] as? String,
                let id = dataArray[6] as? String,
                let timeStamp = dataArray[7] as? String else { return }

            let newMessage = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)

            completion(newMessage)
        }
    }

    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        socket.on("userTypingUpdate") { dataArray, _ in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers) // completionHandler로 딕셔너리를 넘겨준다.
        }
    }
}
