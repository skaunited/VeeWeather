//
//  VeeWeatherDIManager.swift
//  VeeWeather
//
//  Created by Skander Bahri on 17/09/2021.
//

import Foundation
import Swinject

enum TransferControllersType {
    case home
}

protocol VeeWeatherDIManagerProtocol: DIManagerProtocol {
    func controller(for type: TransferControllersType) -> UIViewController?
}


struct VeeWeatherDIManager: VeeWeatherDIManagerProtocol {

    internal var container: Container
    
    init(container: Container, router: Router) {
        self.container = container
        registerViewModels(self.container)
        registerViews(self.container)
    }


    // MARK: - Models
    internal func registerViewModels(_ container: Container) {
        container.register(ViewControllerModelProtocol.self) { resolver in
            log.debug(resolver)
            return ViewControllerModel()
        }.inObjectScope(.container)
    }

    // MARK: - Views
    internal func registerViews(_ container: Container) {
        container.register(ViewController.self) { resolver in
            let controller = StoryboardScene.Main.viewController.instantiate()
            controller.viewModel = resolver.resolve(ViewControllerModelProtocol.self)
            return controller
        }.inObjectScope(.container)
    }
    
    func controller(for type: TransferControllersType) -> UIViewController? {
        switch type {
        case .home:
            return container.resolve(ViewController.self)
        default:
            return nil
        }
    }


}
