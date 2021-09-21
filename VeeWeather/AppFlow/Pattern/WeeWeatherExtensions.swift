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

/**
 Extension of optional, gonna working if the the typeof( ) of the value == String
 - returns: Self, if the value, not nil & "" if the value is nil
 */
extension Optional where Wrapped == String {
    var orEmpty: String { self ?? "" }
}

extension UIColor {
    static let defaultBlue = #colorLiteral(red: 0.231372549, green: 0.4039215686, blue: 0.737254902, alpha: 1)
}

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}
