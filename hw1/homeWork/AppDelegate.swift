//
//  AppDelegate.swift
//  homeWork
//
//  Created by Александр Романов on 17.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var appViewController = UINavigationController(rootViewController: MainViewController())
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }

    private func setupWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appViewController
        window?.makeKeyAndVisible()
    }

}

