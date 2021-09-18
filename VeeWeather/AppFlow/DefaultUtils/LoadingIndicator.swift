//
//  LoadingIndicator.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
import UIKit
class LoadingIndicator: UIView {

  /// ActivityIndicator
  let loader = UIActivityIndicatorView()

  /// Shared Instance
  static let shared: LoadingIndicator = {
    let instance = LoadingIndicator()
    return instance
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    prepared()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Design Indicator and Adding subView to Window
  func prepared() {

    self.backgroundColor = UIColor.white.withAlphaComponent(0.92)
    self.frame = (UIApplication.shared.windows.first?.frame)!

    loader.frame = (UIApplication.shared.windows.first?.frame)!
    loader.style = .large
    loader.center = self.center
    loader.color = UIColor.defaultBlue
    self.addSubview(loader)

  }

  /// Show Indicator View with animation
  func show() {
    let application = UIApplication.shared.delegate as! AppDelegate
    application.window?.addSubview(self)

    loader.startAnimating()

    loader.bringSubviewToFront((application.window?.rootViewController?.view)!)
    // UIApplication.shared.beginIgnoringInteractionEvents()
  }

  /// Hide Indicator View with animation
  func hide() {
    DispatchQueue.main.async {
        self.removeFromSuperview()
        self.loader.stopAnimating()
    }
   

    // if UIApplication.shared.isIgnoringInteractionEvents {
    // UIApplication.shared.endIgnoringInteractionEvents()
    // }
  }

}

