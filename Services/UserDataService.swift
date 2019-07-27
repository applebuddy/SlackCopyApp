//
//  UserDataService.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 27/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import Foundation

final class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    // 유저 데이터와 아바타 이름을 설정한다.
    func setUserData(id: String ,color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarName = avatarName
        self.avatarColor = color
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    
}
