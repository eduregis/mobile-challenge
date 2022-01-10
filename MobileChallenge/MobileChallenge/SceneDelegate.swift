//
//  SceneDelegate.swift
//  MobileChallenge
//
//  Created by Eduardo Oliveira on 10/01/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let listView = ListViewController()
        listView.viewModel = ListViewModel()
        listView.viewModel.output = listView
        let navListView = UINavigationController()
        navListView.viewControllers = [listView]
        navListView.title = "List"
        
        let converterView = ConverterViewController()
        let navConverterView = UINavigationController()
        navConverterView.viewControllers = [converterView]
        navConverterView.title = "Converter"
        
        let tabbarController = UITabBarController()
        tabbarController.setViewControllers([navListView, navConverterView], animated: false)
        tabbarController.tabBar.backgroundColor = .white
        
        guard let items = tabbarController.tabBar.items else { return }
        let images = ["list.dash", "arrow.2.circlepath.circle.fill"]
        for index in 0..<items.count {
            items[index].image = UIImage(systemName: images[index])
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabbarController
        self.window = window
        window.makeKeyAndVisible()
    }
}

