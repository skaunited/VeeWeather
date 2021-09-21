//
//  WeatherModel.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WeatherModel
class WeatherModel: NSObject, NSSecureCoding, Codable {
    static var supportsSecureCoding: Bool = true
    
    let cod: String?
    let message, cnt: Int?
    let list: [List]?
    let city: City?
    
    enum Key:String {
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
    
    
    init(cod: String?, message: Int?, cnt: Int?, list: [List]?, city: City?) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(cod, forKey: Key.cod.rawValue)
        aCoder.encode(message, forKey: Key.message.rawValue)
        aCoder.encode(cnt, forKey: Key.cnt.rawValue)
        aCoder.encode(list, forKey: Key.list.rawValue)
        aCoder.encode(city, forKey: Key.city.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mCod = aDecoder.decodeObject(of: NSString.self ,forKey: Key.cod.rawValue)
        let mMessage = aDecoder.decodeInt64(forKey: Key.message.rawValue)
        let mCnt = aDecoder.decodeInt64(forKey: Key.cnt.rawValue)
        let mList = aDecoder.decodeObject(forKey: Key.list.rawValue) as! [List]?
        let mCity = aDecoder.decodeObject(forKey: Key.city.rawValue) as! City?
        
        self.init(cod: mCod as String?,
                  message: Int(mMessage),
                  cnt: Int(mCnt),
                  list: mList,
                  city: mCity)
    }
}

// MARK: - City
public class City: NSObject, NSSecureCoding, Codable {
    public static var supportsSecureCoding: Bool = true
    
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
    
    enum Key:String {
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(id: Int?, name: String?, coord: Coord?, country: String?, population: Int?, timezone: Int?, sunrise: Int?, sunset: Int?) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Key.id.rawValue)
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(coord, forKey: Key.coord.rawValue)
        aCoder.encode(country, forKey: Key.country.rawValue)
        aCoder.encode(population, forKey: Key.population.rawValue)
        aCoder.encode(timezone, forKey: Key.timezone.rawValue)
        aCoder.encode(sunrise, forKey: Key.sunrise.rawValue)
        aCoder.encode(sunset, forKey: Key.sunset.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mId = aDecoder.decodeInt64(forKey: Key.id.rawValue)
        let mName = aDecoder.decodeObject(forKey: Key.name.rawValue) as! String
        let mCoord = aDecoder.decodeObject(forKey: Key.coord.rawValue) as! Coord?
        let mCountry = aDecoder.decodeObject(forKey: Key.country.rawValue) as! String
        let mPopulation = aDecoder.decodeInt64(forKey: Key.population.rawValue)
        let mTimezone = aDecoder.decodeInt64(forKey: Key.timezone.rawValue)
        let mSunrise = aDecoder.decodeInt64(forKey: Key.sunrise.rawValue)
        let mSunset = aDecoder.decodeInt64(forKey: Key.sunset.rawValue)
        
        self.init(id : Int(mId),
                  name : mName,
                  coord : mCoord,
                  country : mCountry,
                  population : Int(mPopulation),
                  timezone : Int(mTimezone),
                  sunrise : Int(mSunrise),
                  sunset : Int(mSunset))
    }
}

// MARK: - Coord
class Coord: NSObject, NSSecureCoding, Codable {
    static var supportsSecureCoding: Bool = true
    
    let lat, lon: Double?
    
    enum Key:String {
        case lat = "lat"
        case lon = "lon"
    }
    
    init(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(lat, forKey: Key.lat.rawValue)
        aCoder.encode(lon, forKey: Key.lon.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mLat = aDecoder.decodeDouble(forKey: Key.lat.rawValue)
        let mLon = aDecoder.decodeDouble(forKey: Key.lon.rawValue)
        
        self.init(lat : mLat,
                  lon : mLon)
    }
}

// MARK: - List
class List: NSObject,NSSecureCoding, Codable{
    static var supportsSecureCoding: Bool = true
    
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let sys: Sys?
    let dtTxt: String?
    let rain: Rain?
    
    init(dt: Int?, main: MainClass?, weather: [Weather]?, clouds: Clouds?, wind: Wind?, visibility: Int?, pop: Double?, sys: Sys?, dtTxt: String?, rain: Rain?) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.visibility = visibility
        self.pop = pop
        self.sys = sys
        self.dtTxt = dtTxt
        self.rain = rain
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(dt, forKey: "dt")
        aCoder.encode(main, forKey: "main")
        aCoder.encode(weather, forKey: "weather")
        aCoder.encode(clouds, forKey: "clouds")
        aCoder.encode(wind, forKey: "wind")
        aCoder.encode(visibility, forKey: "visibility")
        aCoder.encode(pop, forKey: "pop")
        aCoder.encode(sys, forKey: "sys")
        aCoder.encode(dtTxt, forKey: "dtTxt")
        aCoder.encode(rain, forKey: "rain")
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mDt = aDecoder.decodeInt64(forKey: "dt")
        let mVisibility = aDecoder.decodeInt64(forKey: "visibility")
        let mPop = aDecoder.decodeDouble(forKey: "pop")
        let mDtTxt = aDecoder.decodeObject(of: NSString.self ,forKey: "dtTxt")
        let mWeather = aDecoder.decodeArrayOfObjects(ofClass: Weather.self, forKey: "weather")
        let mClouds = aDecoder.decodeObject(of: Clouds.self ,forKey: "clouds")
        let mMain = aDecoder.decodeObject(of: MainClass.self ,forKey: "main")
        let mRain = aDecoder.decodeObject(of: Rain.self ,forKey: "rain")
        let mSys = aDecoder.decodeObject(of: Sys.self ,forKey: "sys")
        let mWind = aDecoder.decodeObject(of: Wind.self ,forKey: "wind")
        
        self.init(dt: Int(mDt),
                  main: mMain,
                  weather: mWeather,
                  clouds: mClouds,
                  wind: mWind,
                  visibility: Int(mVisibility),
                  pop: mPop ,
                  sys: mSys,
                  dtTxt: mDtTxt as String?,
                  rain: mRain)

    }

    enum CodingKeys: String, CodingKey {
        case dt, main, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
        case weather
    }

}

// MARK: - Clouds
class Clouds:NSObject,NSSecureCoding, Codable {
    static var supportsSecureCoding: Bool = true
    
    let all: Int?
    
    enum Key:String {
        case all = "all"
    }
    
    init(all: Int?) {
        self.all = all
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(all, forKey: Key.all.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mAll = aDecoder.decodeInt64(forKey: Key.all.rawValue)
        
        self.init(all : Int(mAll))
    }
}

// MARK: - MainClass
class MainClass:NSObject,NSSecureCoding, Codable {
    static var supportsSecureCoding: Bool = true
    
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    init(temp: Double?, feelsLike: Double?, tempMin: Double?, tempMax: Double?, pressure:  Int?, seaLevel:  Int?, grndLevel:  Int?, humidity:  Int?, tempKf:  Double?){
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
        self.humidity = humidity
        self.tempKf = tempKf
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(temp, forKey: "temp")
        aCoder.encode(feelsLike, forKey: "feelsLike")
        aCoder.encode(tempMin, forKey: "tempMin")
        aCoder.encode(tempMax, forKey: "tempMax")
        aCoder.encode(pressure, forKey: "pressure")
        aCoder.encode(seaLevel, forKey: "seaLevel")
        aCoder.encode(grndLevel, forKey: "grndLevel")
        aCoder.encode(humidity, forKey: "humidity")
        aCoder.encode(tempKf, forKey: "tempKf")
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let  mTemp = aDecoder.decodeDouble(forKey: "temp")
        let  mFeelsLike = aDecoder.decodeDouble(forKey: "feelsLike")
        let  mTempMin = aDecoder.decodeDouble(forKey: "tempMin")
        let  mTempMax = aDecoder.decodeDouble(forKey: "tempMax")
        
        let  mPressure = aDecoder.decodeInt64(forKey: "pressure")
        let  mSeaLevel = aDecoder.decodeInt64(forKey: "seaLevel")
        let  mGrndLevel = aDecoder.decodeInt64(forKey: "grndLevel")
        let  mHumidity = aDecoder.decodeInt64(forKey: "humidity")
        
        let  mTempKf = aDecoder.decodeDouble(forKey: "tempKf")
                
        self.init(temp: mTemp,
                  feelsLike: mFeelsLike,
                  tempMin:  mTempMin,
                  tempMax:  mTempMax,
                  pressure:  Int(mPressure),
                  seaLevel:  Int(mSeaLevel),
                  grndLevel:  Int(mGrndLevel),
                  humidity:  Int(mHumidity),
                  tempKf:  mTempKf)

    }
}

// MARK: - Rain
class Rain:NSObject,NSSecureCoding, Codable {
    static var supportsSecureCoding: Bool = true
    
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
    
    init(the3H: Double?) {
        self.the3H = the3H
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(the3H, forKey: "the3H")
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mThe3H = aDecoder.decodeDouble(forKey: "the3H")
        self.init(the3H: mThe3H)
    }
}

// MARK: - Sys
class Sys: NSObject,NSSecureCoding, Codable {
    static var supportsSecureCoding: Bool = true
    
    let pod: Pod?
    
    enum Key:String {
        case pod = "pod"
    }
    
    init(pod: Pod?) {
        self.pod = pod
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(pod, forKey: Key.pod.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mPod = aDecoder.decodeObject(forKey: Key.pod.rawValue) as! Pod?
        self.init(pod: mPod)
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

class Weather: NSObject, NSSecureCoding, Codable {
    static var supportsSecureCoding: Bool = true
    
    let id: Int?
    let main: String?
    let desc: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case desc = "description"
        case icon = "icon"
    }
    
    init(id: Int?, main: String?, desc: String?, icon: String?) {
        self.id = id
        self.main = main
        self.desc = desc
        self.icon = icon
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: CodingKeys.id.rawValue)
        coder.encode(main, forKey: CodingKeys.main.rawValue)
        coder.encode(desc, forKey: CodingKeys.desc.rawValue)
        coder.encode(icon, forKey: CodingKeys.icon.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mId = coder.decodeInt64(forKey: CodingKeys.id.rawValue)
        let mMain = coder.decodeObject(of: NSString.self ,forKey: CodingKeys.main.rawValue)
        let mDesc = coder.decodeObject(of: NSString.self ,forKey: CodingKeys.desc.rawValue)
        let mIcon = coder.decodeObject(of: NSString.self ,forKey: CodingKeys.icon.rawValue)
        
        self.init(id: Int(mId),
                  main: mMain as String?,
                  desc: mDesc as String?,
                  icon: mIcon as String?)
    }
    
}

// MARK: - Wind
class Wind: NSObject,NSSecureCoding, Codable {
    static var supportsSecureCoding: Bool = true
    
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
    enum Key:String {
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }
    
    init(speed: Double?, deg: Int?, gust: Double?) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(speed, forKey: Key.speed.rawValue)
        coder.encode(deg, forKey: Key.deg.rawValue)
        coder.encode(gust, forKey: Key.gust.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mSpeed = coder.decodeDouble(forKey: Key.speed.rawValue)
        let mDeg = coder.decodeInt64(forKey: Key.deg.rawValue)
        let mGust = coder.decodeDouble(forKey: Key.gust.rawValue)
        
        self.init(speed: mSpeed, deg: Int(mDeg), gust: mGust)
    }
}

