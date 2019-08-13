//
//  AppDelegate.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 18/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationDidBecomeActive(_: UIApplication) {
        // 앱이 Active 상태가 될때 소켓연결
        SocketService.instance.establishConnection()
    }

    func applicationWillTerminate(_: UIApplication) {
        // 앱 종료 시 소켓 연결 종료
        SocketService.instance.closeConnection()
    }
}
