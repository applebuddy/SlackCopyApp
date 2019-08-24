//
//  MessageService.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 08/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class MessageService {
    static let instance = MessageService()

    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel: Channel?
    var unreadChannels = [String]()
    /// * 현재 유저의 채널 정보를 불러온다.
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { response in

            // 에러가 발생한다면??
            if response.result.error == nil {
                guard let data = response.data else { return }

                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    // 채널이 적용되었음을 노티로 알려준다.
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                } catch {
                    print("JSON Decode Error!: \(error.localizedDescription)")
                }

            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }

    // 특정 채널의 모든 메세지를 찾는다.
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { response in

            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                guard let json = try? JSON(data: data).array,
                    let json_ = json else { return }

                for item in json_ {
                    let messageBody = item["messageBody"].stringValue
                    let channelId = item["channelId"].stringValue
                    let id = item["_id"].stringValue
                    let userName = item["userName"].stringValue
                    let userAvatar = item["userAvatar"].stringValue
                    let userAvatarColor = item["userAvatarColor"].stringValue
                    let timeStamp = item["timeStamp"].stringValue

                    // json 파싱으로 받아온 message Data를 생성한다.
                    let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                    self.messages.append(message)
                }
                print(self.messages)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }

    // 모든 메세지를 제거한다.
    func clearMessages() {
        messages.removeAll()
    }

    // 모든 채널을 정리한다.
    func clearChannels() {
        channels.removeAll()
    }
}
