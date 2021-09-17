//
//  AppDelegate.swift
//  VeeWeather
//
//  Created by Skander Bahri on 15/09/2021.
//

import UIKit
import CoreData
import Swinject
import SwiftyBeaver
let log = SwiftyBeaver.self

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - STATIC K
    struct K {
        static let debugFormat = "$DHH:mm:ss$d $L $M"
        static let verbose = "💜 VERBOSE"
        static let debug = "💚 DEBUG"
        static let warning = "💛 WARNING"
        static let info = "💙 INFO"
        static let error = "❤️ ERROR"
    }
    public var coordinator: BaseCoordinatorProtocol?
    var window: UIWindow?
    var container: Container?
    lazy var router = RouterImp(rootController: self.rootController)
    
    var rootController: UINavigationController {
        return (self.window?.rootViewController as? UINavigationController)!
    }
    private lazy var appCoordinator: VeeWeatherCoordinator? = self.makeCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - SwiftyBeaver
        let console = ConsoleDestination()
        console.format = K.debugFormat
        console.levelString.verbose = K.verbose
        console.levelString.debug = K.debug
        console.levelString.info = K.info
        console.levelString.warning = K.warning
        console.levelString.error = K.error
        log.addDestination(console)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if self.window?.rootViewController == nil {
            self.window?.rootViewController = UINavigationController()
        }
        
        container = Container {_ in}
        appCoordinator?.start()
        return true
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "VeeWeather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - private methods
    private func makeCoordinator() -> VeeWeatherCoordinator? {
        guard let container = container else { return nil }
        let coordinator = VeeWeatherCoordinator(
            router: router,
            container: container
        )
        return coordinator
    }
    
}

