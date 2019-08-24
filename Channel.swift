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
    //   => private(set) var 로 사용해도 동일한 역할을 한다.
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var _id: String!

    init(_id: String, name: String, description: String) {
        self._id = _id
        self.name = name
        self.description = description
    }
}
