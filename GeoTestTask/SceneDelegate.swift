//
//  SceneDelegate.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 25.10.2021.
//

import UIKit
import Kingfisher

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Clearing image cache
        ImageCache.default.clearCache()

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let vc = HomeViewController(viewModel: UsersListViewModel())
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isTranslucent = false
        self.window?.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

