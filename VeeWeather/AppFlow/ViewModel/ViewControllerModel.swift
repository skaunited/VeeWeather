//
//  ViewControllerModel.swift
//  VeeWeather
//
//  Created by Skander Bahri on 16/09/2021.
//

import Foundation

protocol ViewControllerModelProtocol {
    func getWeatherData()
}

class ViewControllerModel: ViewControllerModelProtocol{
    func getWeatherData(){
        Services.getWeatherData(city: "Paris,fr") { weatherModel in
            log.info(weatherModel)
        }
    }
}
