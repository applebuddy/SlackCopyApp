//
//  SocketService.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 13/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import SocketIO
import UIKit

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
                let channelId = dataArray[2] as? String else { return }

            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
}
