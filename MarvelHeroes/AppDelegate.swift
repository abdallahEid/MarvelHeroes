//
//  AppDelegate.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 7/31/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = Reachability()!
    static var isConnectedToInternet:Bool?
    let dataController = DataController(modelName: "MarvelHeroes")
    
    func checkInternetConnection(){
        reachability.whenReachable = { reachability in
            AppDelegate.isConnectedToInternet = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "internet"), object: self, userInfo: ["isConnected": true])
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            AppDelegate.isConnectedToInternet = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "internet"), object: self, userInfo: ["isConnected": false])
            var vc = self.window?.rootViewController
            while (vc?.presentedViewController != nil)
            {
                vc = vc?.presentedViewController
            }
            vc?.showAlert(title: "No Internet", message: "Please, check your interner connection")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func loadCoreDataStack(){
        dataController.load {}
        let navigationController = window?.rootViewController as! UINavigationController
        let charactersViewController = navigationController.topViewController as! CharactersViewController
        charactersViewController.dataController = dataController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        checkInternetConnection()
        loadCoreDataStack()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        dataController.saveViewContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        dataController.saveViewContext()

    }


}

