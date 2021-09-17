//
//  Presentable.swift
//  VeeWeather
//
//  Created by Skander Bahri on 17/09/2021.
//

import UIKit

public protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController? {
        return self
    }
}
