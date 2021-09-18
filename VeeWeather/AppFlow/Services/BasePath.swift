//
//  BasePath.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//
import Foundation

enum BasePath: String {
    case baseUrl
      /// variable path qui retourne l'url a utiliser
      var basePath: String {
          switch self {
          case .baseUrl:  return "https://api.openweathermap.org/data/2.5/forecast"
          }
      }
}

/// concatination a l'url de base
extension BasePath: CustomStringConvertible {
    var description: String { return basePath  }
}

