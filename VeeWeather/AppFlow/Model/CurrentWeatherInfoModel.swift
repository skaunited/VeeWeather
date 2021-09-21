//
//  CurrentWeatherInfoModel.swift
//  VeeWeather
//
//  Created by Skander Bahri on 21/09/2021.
//

import Foundation

struct CurrentWeatherInfoModel : Codable {
    let currentTemp: String?
    let weatherState: String?
    
    init(currentTemp: String? = nil, weatherState: String? = nil){
        self.currentTemp = currentTemp
        self.weatherState = weatherState
    }
}
