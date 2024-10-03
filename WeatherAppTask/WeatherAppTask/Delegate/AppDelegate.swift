//
//  AppDelegate.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setNewRoot()
        return true
    }

    private func setNewRoot() {
        let weatherService = WeatherAPIService(apiKey: Constants.apiKey)
        let weatherViewModel = WeatherViewModel(weatherService: weatherService)
        let weatherViewController = WeatherAppViewController(viewModel: weatherViewModel)
        let navigationController = UINavigationController(rootViewController: weatherViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

