//
//  AppDelegate.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK:  Declare CoreData Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Aloscreen")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        checkLoggedInUser()
        
        
        return true
    }
    
    func checkLoggedInUser() {
        
        do {
            let sb: UIStoryboard?
            let allUser = try UsersOperational.readUser()
            let filterLoggedIn = allUser.filter { $0.isLoggedIn == true }
            print(filterLoggedIn)
            if filterLoggedIn.count > 0 {
                sb = UIStoryboard(name: "MainTabBar", bundle: nil)
                guard let rootVC = sb?.instantiateViewController(withIdentifier: "MainTabBarStoryboard") as? MainTabBarViewController else {
                    print("VIEW CONTROLLER NOT FOUND!")
                    return
                }
                window?.rootViewController = rootVC
                window?.makeKeyAndVisible()
            } else {
                sb = UIStoryboard(name: "Login", bundle: nil)
                guard let rootVC = sb?.instantiateViewController(withIdentifier: "NavLoginStoryboard") as? UINavigationController else {
                    print("VIEW CONTROLLER NOT FOUND!")
                    return
                }
                window?.rootViewController = rootVC
                window?.makeKeyAndVisible()
            }
        } catch let error {
            print(error)
        }
    }

}

