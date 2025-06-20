//
//  SceneDelegate.swift
//  ImageFeed
//
//  Created by Irina Gubina on 24.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window.rootViewController = SplashViewController()
        self.window = window
        window.makeKeyAndVisible()
        
    }
}

