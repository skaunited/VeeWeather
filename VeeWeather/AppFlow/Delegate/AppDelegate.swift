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
        static let token = "18bcbc79a7758a7b9832571bd2962c0a"
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
        DefaultUtils.sharedInstance.token = K.token
        DefaultUtils.sharedInstance.syncronise()
        
        container = Container {_ in}
        appCoordinator?.start()
        return true
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

