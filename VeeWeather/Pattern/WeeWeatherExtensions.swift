//
//  WeeWeatherExtensions.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("❤️ ERROR Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}
