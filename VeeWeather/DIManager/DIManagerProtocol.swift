//
//  DIManagerProtocol.swift
//  VeeWeather
//
//  Created by Skander Bahri on 17/09/2021.
//

import Foundation
import Swinject

public protocol DIManagerProtocol {
    var container: Container { get set }
    func registerViews(_ container: Container)
    func registerViewModels(_ container: Container)
    func cleanContainer()
}

// To make function optionnal
public extension DIManagerProtocol {
    func registerViews(_ container: Container) {}
    func registerViewModels(_ container: Container) {}
    func cleanContainer() {
        container.removeAll()
    }
}
