//
//  CoreDataManager.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//

import Foundation
import CoreData

class CoreDataManager: NSObject{
    
    private override init() {
        super.init()
        
        applicationLibraryDirectory()
    }
    // Create a shared Instance
    static let _shared = CoreDataManager()
    
    // Shared Function
    class func shared() -> CoreDataManager{
        return _shared
    }
    
    // Get the location where the core data DB is stored
    
    private lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1])
        return urls[urls.count-1]
    }()
    
    private func applicationLibraryDirectory() {
        print(applicationDocumentsDirectory)
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    // MARK: - Core Data stack
    
    // Get the managed Object Context
    lazy var managedObjectContext = {
        
        return self.persistentContainer.viewContext
    }()
    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "JSONToCoreDataAgain")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func prepare(dataForSaving: [WeatherModel]){
        
        // loop through all the data received from the Web and then convert to managed object and save them
        _ = dataForSaving.map{self.createWeatherModelEntityFrom(weatherModel: $0)}
        saveData()
    }
    
    // Save the data in Database
    func saveData(){
        
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Save Data in background
    func saveDataInBackground() {
        
        persistentContainer.performBackgroundTask { (context) in
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    private func createWeatherModelEntityFrom(weatherModel: WeatherModel) -> WeatherModelEntity?{
        guard
            let cod = weatherModel.cod,
            let message = weatherModel.message,
            let cnt = weatherModel.cnt,
            let listArray = weatherModel.list,
            let city = createCityEntityFrom(city: weatherModel.city)
        else {
            return nil
        }
        
        var listEntityArray : [ListEntity] = []
        
        for listItem in listArray {
            listEntityArray.append(createListEntityFrom(list: listItem) ?? ListEntity(context: self.managedObjectContext))
        }
        // Convert
        let weatherModelEntity = WeatherModelEntity(context: self.managedObjectContext)
        weatherModelEntity.cod = cod
        weatherModelEntity.message = Int64(message)
        weatherModelEntity.cnt = Int64(cnt)
        weatherModelEntity.list = listEntityArray
        weatherModelEntity.city = city
        
        return weatherModelEntity
    }
    
    private func createCityEntityFrom(city: City?) -> CityEntity? {
        guard
            let id = city?.id,
            let name = city?.name,
            let coord = createCoordFrom(coord: city?.coord),
            let country = city?.country,
            let population = city?.population,
            let timezone = city?.timezone,
            let sunrise = city?.sunrise,
            let sunset = city?.sunset
        else {
            return nil
        }
        let cityEntity = CityEntity(context: self.managedObjectContext)
        cityEntity.id = Int64(id)
        cityEntity.name = name
        cityEntity.coord = coord
        cityEntity.country = country
        cityEntity.population = Int64(population)
        cityEntity.timezone = Int64(timezone)
        cityEntity.sunset = Int64(sunset)
        cityEntity.sunrise = Int64(sunrise)
        
        return cityEntity
    }
    
    private func createCoordFrom(coord: Coord?) -> CoordEntity?{
        guard let coord = coord, let lat = coord.lat, let lon = coord.lon else {
            return nil
        }
        let coordEntity = CoordEntity(context: self.managedObjectContext)
        coordEntity.lat = lat
        coordEntity.lon = lon
        
        return coordEntity
    }
    
    private func createListEntityFrom(list: List) -> ListEntity? {
        guard
            let dt = list.dt,
            let main = createMainClassEntityFrom(mainClass: list.main),
            let weatherArray = list.weather,
            let clouds = createCouldsEntityFrom(clouds: list.clouds),
            let wind = createWindEntityFrom(wind: list.wind),
            let visibility = list.visibility,
            let pop = list.pop,
            let sys = createSysEntityFrom(sys: list.sys),
            let dtTxt = list.dtTxt,
            let rain = createRainEntityFrom(rain: list.rain)
        else {
            return nil
        }
        
        var weatherEntityArray : [WeatherEntity]? = []
        for weatherItem in weatherArray {
            weatherEntityArray?.append(createWeatherEntityFrom(weather: weatherItem) ?? WeatherEntity(context: self.managedObjectContext))
        }
        
        let listEntity = ListEntity(context: self.managedObjectContext)
        listEntity.dt = Int64(dt)
        listEntity.main = main
        listEntity.weather = weatherEntityArray
        listEntity.clouds = clouds
        listEntity.wind = wind
        listEntity.visibility = Int64(visibility)
        listEntity.pop = pop
        listEntity.sys = sys
        listEntity.dtTxt = dtTxt
        listEntity.rain = rain
        return listEntity
    }

    private func createMainClassEntityFrom(mainClass: MainClass?) -> MainClassEntity? {
        guard
            let temp = mainClass?.temp,
            let feelsLike = mainClass?.feelsLike,
            let tempMin = mainClass?.tempMin,
            let tempMax = mainClass?.tempMax,
            let pressure = mainClass?.pressure,
            let seaLevel = mainClass?.seaLevel,
            let grndLevel = mainClass?.grndLevel,
            let humidity = mainClass?.humidity,
            let tempKf = mainClass?.tempKf
        else {
            return nil
        }
        let mainClassEntity = MainClassEntity(context: self.managedObjectContext)
        mainClassEntity.temp = temp
        mainClassEntity.feelsLike = feelsLike
        mainClassEntity.tempMin = tempMin
        mainClassEntity.tempMax = tempMax
        mainClassEntity.pressure = Int64(pressure)
        mainClassEntity.seaLevel = Int64(seaLevel)
        mainClassEntity.grndLevel = Int64(grndLevel)
        mainClassEntity.humidity = Int64(humidity)
        mainClassEntity.tempKf = tempKf
        
        return mainClassEntity
    }
    
    private func createWeatherEntityFrom(weather: Weather?) -> WeatherEntity? {
        guard
            let id = weather?.id,
            let icon = weather?.icon
        else {
            return nil
        }
        let mainEnumEntity = MainEnumEntity(context: self.managedObjectContext)
        mainEnumEntity.clear = MainEnum.clear.rawValue
        mainEnumEntity.clouds = MainEnum.clouds.rawValue
        mainEnumEntity.rain = MainEnum.rain.rawValue
        
        let descriptionEntity = DescriptionEntity(context: self.managedObjectContext)
        descriptionEntity.brokenClouds = Description.brokenClouds.rawValue
        descriptionEntity.clearSky = Description.clearSky.rawValue
        descriptionEntity.fewClouds = Description.fewClouds.rawValue
        descriptionEntity.lightRain = Description.lightRain.rawValue
        descriptionEntity.overcastClouds = Description.overcastClouds.rawValue
        descriptionEntity.scatteredClouds = Description.scatteredClouds.rawValue
        
        let weatherEntity = WeatherEntity(context: self.managedObjectContext)
        weatherEntity.id = Int64(id)
        weatherEntity.main = mainEnumEntity
        weatherEntity.weatherDescription = descriptionEntity
        weatherEntity.icon = icon
        
        return weatherEntity
    }
    
    
    private func createCouldsEntityFrom(clouds: Clouds?) -> CloudsEntity? {
        guard let all = clouds?.all else {
            return nil
        }
        let cloudsEntity = CloudsEntity(context: self.managedObjectContext)
        cloudsEntity.all = Int64(all)
        return cloudsEntity
    }
    
    private func createWindEntityFrom(wind: Wind?) -> WindEntity? {
        guard let speed = wind?.speed, let deg = wind?.deg, let gust = wind?.gust else {
            return nil
        }
        let windEntity = WindEntity(context: self.managedObjectContext)
        windEntity.speed = speed
        windEntity.deg = Int64(deg)
        windEntity.gust = gust
        
        return windEntity
    }
    
    private func createSysEntityFrom(sys: Sys?) -> SysEntity? {
        guard let pod = createPodEntityFrom(pod: sys?.pod) else {
            return nil
        }
        let sysEntity = SysEntity(context: self.managedObjectContext)
        sysEntity.pod = pod
        
        return sysEntity
    }
    
    private func createRainEntityFrom(rain: Rain?) -> RainEntity? {
        guard let the3tH = rain?.the3H else {
            return nil
        }
        let rainEntity = RainEntity(context: self.managedObjectContext)
        rainEntity.the3H = the3tH
        return rainEntity
    }
    
    private func createPodEntityFrom(pod: Pod?) -> PodEntity? {
        let podEntity = PodEntity(context: self.managedObjectContext)
        podEntity.d = Pod.d.rawValue
        podEntity.n = Pod.n.rawValue
        
        return podEntity
    }
}
