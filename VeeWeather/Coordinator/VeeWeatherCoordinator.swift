//
//  VeeWeatherCoordinator.swift
//  VeeWeather
//
//  Created by Skander Bahri on 17/09/2021.
//

import Foundation
import Swinject

open class VeeWeatherCoordinator: BaseCoordinator {
    internal let router: Router
    var diManager: VeeWeatherDIManagerProtocol
    
    // MARK: - public methods
    public init(router: Router, container: Container) {
        self.router = router
        self.diManager = VeeWeatherDIManager(container: container, router: router)
        super.init(container: container)
    }

    open override func start() {
        if let home = diManager.controller(for: .home) as? ViewController {
            home.viewModel = container.resolve(ViewControllerModelProtocol.self)
            router.setRootModule(home, hideBar: true)
        }
    }
}
