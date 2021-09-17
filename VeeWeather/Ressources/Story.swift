//
//  Storyboards-scenes.swift
//  VeeWeather
//
//  Created by Skander Bahri on 16/09/2021.
//

//import Foundation
//import UIKit
//
//internal enum StoryboardScene {
//    internal enum MainStoryboard: StoryboardType {
//      internal static let storyboardName = "Main"
//
//        internal static let mainViewController = SceneType<VeeWeather.ViewController>(storyboard: MainStoryboard.self, identifier: "ViewController")
//    }
//}
//
//// MARK: - Implementation Details
//internal struct SceneType<T: UIViewController> {
//  internal let storyboard: StoryboardType.Type
//  internal let identifier: String
//
//  internal func instantiate() -> T {
//    let identifier = self.identifier
//    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
//      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
//    }
//    return controller
//  }
//
//  @available(iOS 13.0, tvOS 13.0, *)
//  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
//    return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
//  }
//}
//
//internal protocol StoryboardType {
//  static var storyboardName: String { get }
//}
//
//internal extension StoryboardType {
//  static var storyboard: UIStoryboard {
//    let name = self.storyboardName
//    return UIStoryboard(name: name, bundle: BundleToken.bundle)
//  }
//}
//
//private final class BundleToken {
//  static let bundle: Bundle = {
//    #if SWIFT_PACKAGE
//    return Bundle.module
//    #else
//    return Bundle(for: BundleToken.self)
//    #endif
//  }()
//}
