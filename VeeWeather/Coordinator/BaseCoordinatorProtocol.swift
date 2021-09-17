//
//  BaseCoordinatorProtocol.swift
//  VeeWeather
//
//  Created by Skander Bahri on 17/09/2021.
//

import UIKit

public protocol BaseCoordinatorProtocol: Coordinator, FlowOutput {

    /// this function can add  dependency to a specific coordinator
    func addDependency(_ coordinator: Coordinator)

    /// this function can remove dependency recursively to a specific coordinator
    func removeDependency(_ coordinator: Coordinator?)

    /// this function return the viewcontroller type for destination
    func viewcontrollerType<T>(for destination: T) -> UIViewController.Type?
}

public extension BaseCoordinatorProtocol {
    // make it optionnal
    func viewcontrollerType<T>(for destination: T) -> UIViewController.Type? {
        nil
    }
}

public protocol Coordinator: class {
    func start()

    func start<T>(destination: T, navigationType: NavigationType)

    func start<T>(destination: T, navigationType: NavigationType, data: Any?)

    func canStart<T>(destination: T, canNavigate: @escaping (Bool, Any?) -> Void)
}

public extension Coordinator {
    func canStart<T>(destination: T, canNavigate: @escaping (Bool, Any?) -> Void) {
        // Default navigation for coordinators
        canNavigate(true, nil)
    }

    func start<T>(destination: T, navigationType: NavigationType, data: Any?) {
        // gateway to call start without data
        start(destination: destination, navigationType: navigationType)
    }
}

public typealias Closure = () -> Void
public protocol FlowOutput {
    var finishFlow: Closure? { get set }
}

public enum NavigationType {
    case root, fromAnotherModule, push, present
}
