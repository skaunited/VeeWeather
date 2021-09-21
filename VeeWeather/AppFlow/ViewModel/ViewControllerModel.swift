//
//  ViewControllerModel.swift
//  VeeWeather
//
//  Created by Skander Bahri on 16/09/2021.
//

import Foundation
import RxSwift


protocol ViewControllerModelProtocol {
    var currentWeatherStateFinished: PublishSubject<CurrentWeatherInfoModel> { get }
    var currentCityFinished: PublishSubject<[CityEntity]?> { get }
    
    func fetchWeatherData(dataStore: DataStore, city: String)
    func retriveDataFromCoreData(dataStore: DataStore) -> [DateComponents:[ListEntity]]?
    func fetchTheCurrentWeatherState(dict: [DateComponents:[ListEntity]])
    func retriveCityDataFromCoreData(dataStore: DataStore)
}

class ViewControllerModel: ViewControllerModelProtocol {

    var currentCityFinished = PublishSubject<[CityEntity]?>()
    var currentWeatherStateFinished = PublishSubject<CurrentWeatherInfoModel>()

    
    func fetchWeatherData(dataStore: DataStore, city: String){
        dataStore.fetchWeatherData(city: city)
    }
    
    func retriveDataFromCoreData(dataStore: DataStore) -> [DateComponents:[ListEntity]]? {
        return dataStore.coreDataManager.retrieveData()
    }
    
    func retriveCityDataFromCoreData(dataStore: DataStore){
        self.currentCityFinished.onNext(dataStore.coreDataManager.retrieveCityData())
    }
    
    func fetchTheCurrentWeatherState(dict: [DateComponents:[ListEntity]]) {
        let dictValInc = dict.sorted { ($0.key.year!,$0.key.month! ,$0.key.day!) < ($1.key.year!, $1.key.month!,$1.key.day!) }
        guard dictValInc.count > 0 else { return }
        var currentTemp: String?
        var weatherState: String?
  
        let secondIndexEntity: MainClassEntity? = dictValInc[0].value[0].main
        if let temp = secondIndexEntity?.temp {
            currentTemp = "\(convertKelvinToCelsius(digits: 0, number: temp))°"
        }

  

        if let weatherEntity = dictValInc[0].value[0].weather {
            if let main = weatherEntity.main {
                weatherState = main
            }
        }
        let currentWeatherModel = CurrentWeatherInfoModel(currentTemp: currentTemp,
                                                          weatherState: weatherState)

        self.currentWeatherStateFinished.onNext(currentWeatherModel)
    }
}
