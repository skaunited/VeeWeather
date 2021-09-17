//
//  Router.swift
//  VeeWeather
//
//  Created by Skander Bahri on 17/09/2021.
//

import UIKit

public protocol Router: class, Presentable {
    var delegate: UINavigationControllerDelegate? { get set }

    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, hideBottomBar: Bool)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)

    func popModule()
    func popModule(animated: Bool)
    func popToLastModule<T: Presentable>(ofType type: T.Type, animated: Bool)
    func popToRootModule(animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)

    func changeNavigationBarVisibility(_ show: Bool)

    func viewControllerExist<T: Presentable>(forType presentableType: T.Type) -> Bool
}

public extension Router {
    // make it optionnal
    func viewControllerExist<T: Presentable>(forType presentableType: T.Type) -> Bool {
        false
    }
}
