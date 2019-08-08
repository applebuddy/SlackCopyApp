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

    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { response in

            // 에러가 발생한다면??
            if response.result.error == nil {
                guard let data = response.data else { return }
                guard let json = try? JSON(data: data).array else { return }

                for item in json! {
                    let name = item["name"].stringValue
                    let channelDescription = item["description"].stringValue
                    let id = item["_id"].stringValue
                    let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                    self.channels.append(channel)
                }
                print(self.channels[0].channelTitle)
                completion(true)

            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}