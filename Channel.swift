//
//  Channel.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 08/08/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    // ✭ public private(set) var -> 읽기 전용 변수라는 의미
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
