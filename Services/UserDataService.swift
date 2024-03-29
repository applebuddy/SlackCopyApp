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

    // public private(set) var : 읽기 전용 변수
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""

    // 유저 데이터와 아바타 이름을 설정한다.
    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.email = email
        self.name = name
    }

    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }

    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped

        var red, green, blue, alpha: NSString?

        scanner.scanUpToCharacters(from: comma, into: &red)
        scanner.scanUpToCharacters(from: comma, into: &green)
        scanner.scanUpToCharacters(from: comma, into: &blue)
        scanner.scanUpToCharacters(from: comma, into: &alpha)

        let defaultColor: UIColor = .lightGray

        guard let rUnwrapped = red,
            let gUnwrapped = green,
            let bUnwrapped = blue,
            let aUnwrapped = alpha else { return defaultColor }

        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)

        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)

        return newUIColor
    }

    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
}
