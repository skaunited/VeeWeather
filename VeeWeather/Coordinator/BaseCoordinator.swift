//
//  BaseCoordinator.swift
//  VeeWeather
//
//  Created by Skander Bahri on 17/09/2021.
//

import Foundation
import Swinject

open class BaseCoordinator: NSObject, BaseCoordinatorProtocol {
    public var finishFlow: Closure?
    open func start() {}
    open func start<T>(destination: T, navigationType: NavigationType) { }
    open func viewcontrollerType<T>(for destination: T) -> UIViewController.Type? { nil }

    var childCoordinators: [Coordinator] = []
    public var container: Container

    public init(container: Container) {
        self.container = container
    }

    // add only unique object
    open func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    open func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }

        // Clear child-coordinators recursively
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeDependency($0) })
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
