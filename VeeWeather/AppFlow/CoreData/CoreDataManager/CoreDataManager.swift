//
//  CoreDataManager.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//

import Foundation
import CoreData

class CoreDataManager: NSObject{
    
    struct K {
        static let dateFormatter = "yyyy-MM-dd HH:mm:ss"
    }
    
    private override init() {
        super.init()
        applicationLibraryDirectory()
    }
    // Create a shared Instance
    static let sharedInstance = CoreDataManager()
    
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
        let container = NSPersistentContainer(name: "VeeWeather")
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
    
    func prepare(dataForSaving: WeatherModel){
        // loop through all the data received from the Web and then convert to managed object and save them
        //let _ = self.createListEntityFrom(model: dataForSaving)
        //let _ = self.createWeatherModelEntityFrom(weatherModel: dataForSaving)
        self.createWeatherMainEntityFrom(weatherModel: dataForSaving)
        self.createCityEntityFrom(city: dataForSaving.city)
        saveData(dataForSaving: dataForSaving)
    }
    
    // Save the data in Database
    func saveData(dataForSaving: WeatherModel){
        
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
    
    func retrieveData() -> [DateComponents:[ListEntity]]? {
        let managedContext = self.managedObjectContext
        do {
            let result: [ListEntity] = try managedContext.fetch(ListEntity.fetchRequest())
            
            let groupDic = Dictionary(grouping: result) { (listItem) -> DateComponents in
                let date = Calendar.current.dateComponents([.day, .year, .month], from: (convertDateStringToDate(formatter: K.dateFormatter,
                                                                                                                 dateString: listItem.dtTxt.orEmpty)))
                return date
            }
            return groupDic
        } catch (let error){
            log.error("Failed Retrive: \(error)")
            return nil
        }
    }
    
    func retrieveCityData() -> [CityEntity]? {
        let managedContext = self.managedObjectContext
        do {
            let result: [CityEntity] = try managedContext.fetch(CityEntity.fetchRequest())
            return result
        } catch (let error){
            log.error("Failed Retrive: \(error)")
            return nil
        }
    }
    
    
    func deleteData(){
        let fetchWeatherModelRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WeatherModelEntity")
        let deleteWeatherModelRequest = NSBatchDeleteRequest(fetchRequest: fetchWeatherModelRequest)

        let fetchCityEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CityEntity")
        let deleteCityEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchCityEntityRequest)
        
        let fetchCloudsEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CloudsEntity")
        let deleteCloudsEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchCloudsEntityRequest)
        
        let fetchCoordEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CoordEntity")
        let deleteCoordEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchCoordEntityRequest)
        
        let fetchListEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ListEntity")
        let deleteListEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchListEntityRequest)
        
        let fetchMainClassEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MainClassEntity")
        let deleteMainClassEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchMainClassEntityRequest)
        
        let fetchPodEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PodEntity")
        let deletePodEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchPodEntityRequest)
        
        let fetchRainEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RainEntity")
        let deleteRainEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchRainEntityRequest)
        
        let fetchWindEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WindEntity")
        let deleteWindEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchWindEntityRequest)
        
        let fetchSysEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SysEntity")
        let deleteSysEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchSysEntityRequest)
        
        let fetchWeatherEntityRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WeatherEntity")
        let deleteWeatherEntityRequest = NSBatchDeleteRequest(fetchRequest: fetchWeatherEntityRequest)
        
        do {
            try self.managedObjectContext.execute(deleteWeatherModelRequest)
            
            try self.managedObjectContext.execute(deleteCityEntityRequest)
            try self.managedObjectContext.execute(deleteCloudsEntityRequest)
            
            try self.managedObjectContext.execute(deleteCoordEntityRequest)
            
            try self.managedObjectContext.execute(deleteListEntityRequest)
            
            try self.managedObjectContext.execute(deleteMainClassEntityRequest)
            
            try self.managedObjectContext.execute(deletePodEntityRequest)
            
            try self.managedObjectContext.execute(deleteRainEntityRequest)
            
            try self.managedObjectContext.execute(deleteWindEntityRequest)
            
            try self.managedObjectContext.execute(deleteSysEntityRequest)
            
            try self.managedObjectContext.execute(deleteWeatherEntityRequest)
            
        } catch let error as NSError {
            // TODO: handle the error
            fatalError("Unresolved error \(error), \(error.userInfo)")
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
    
   public func fetechData()  {
        let contractors: [ListEntity] = WeatherModelEntity(context: self.managedObjectContext).value(forKey: "list") as! [ListEntity]

        for person in contractors {
            print(person.dt)
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
    
    private func createWeatherMainEntityFrom(weatherModel: WeatherModel){
        guard let list = weatherModel.list else { return }
        for item in list {
            guard
                let dt = item.dt,
                let dtText = item.dtTxt,
                let main = item.main,
                let weather = item.weather
            else {
                return
            }
            let listEntity = ListEntity(context: self.managedObjectContext)
            listEntity.dt = Int64(dt)
            listEntity.dtTxt = dtText
            listEntity.main = createMainClassEntityFrom(main: main)
            listEntity.weather = createWeatherEntityFrom(weatherArray: weather)
        }
    }
    
    private func createWeatherEntityFrom(weatherArray: [Weather]?) -> WeatherEntity? {
        guard
            let weatherArray = weatherArray,
            weatherArray.count > 0
        else { return nil }
        let weatherItem = weatherArray[0]
        
        let id = weatherItem.id
        let icon = weatherItem.icon
        let main = weatherItem.main
        let desc = weatherItem.desc
        let weatherEntity = WeatherEntity(context: self.managedObjectContext)
        weatherEntity.id = Int64(id ?? 0)
        weatherEntity.main = main
        weatherEntity.desc = desc
        weatherEntity.icon = icon
        
        return weatherEntity
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
            let main = createMainClassEntityFrom(main: list.main),
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
        
        
        let listEntity = ListEntity(context: self.managedObjectContext)
        listEntity.dt = Int64(dt)
        listEntity.main = main
        listEntity.clouds = clouds
        listEntity.wind = wind
        listEntity.visibility = Int64(visibility)
        listEntity.pop = pop
        listEntity.sys = sys
        listEntity.dtTxt = dtTxt
        listEntity.rain = rain
        return listEntity
    }
    
    private func createListEntityFrom(model: WeatherModel) -> [ListEntity]? {
        guard let list = model.list else { return nil }
        var listEntityArray = [ListEntity]()
        for item in list {
            guard
                let dt = item.dt,
                let main = createMainClassEntityFrom(main: item.main),
                let clouds = createCouldsEntityFrom(clouds: item.clouds),
                let wind = createWindEntityFrom(wind: item.wind),
                let visibility = item.visibility,
                let pop = item.pop,
                let sys = createSysEntityFrom(sys: item.sys),
                let dtTxt = item.dtTxt,
                let rain = createRainEntityFrom(rain: item.rain)
            else {
                return nil
            }
            
            let listEntity = ListEntity(context: self.managedObjectContext)
            listEntity.dt = Int64(dt)
            listEntity.main = main
            listEntity.clouds = clouds
            listEntity.wind = wind
            listEntity.visibility = Int64(visibility)
            listEntity.pop = pop
            listEntity.sys = sys
            listEntity.dtTxt = dtTxt
            listEntity.rain = rain
            listEntityArray.append(listEntity)
        }
        
        

        return listEntityArray
    }

    private func createMainClassEntityFrom(main: MainClass?) -> MainClassEntity? {
        let mainClassEntity = MainClassEntity(context: self.managedObjectContext)
        mainClassEntity.temp = main?.temp ?? 0
        mainClassEntity.feelsLike = main?.feelsLike ?? 0
        mainClassEntity.tempMin = main?.tempMin ?? 0
        mainClassEntity.tempMax = main?.tempMax ?? 0
        mainClassEntity.pressure = Int64(main?.pressure ?? 0)
        mainClassEntity.seaLevel = Int64(main?.seaLevel ?? 0)
        mainClassEntity.grndLevel = Int64(main?.grndLevel ?? 0)
        mainClassEntity.humidity = Int64(main?.humidity ?? 0)
        mainClassEntity.tempKf = main?.tempKf ?? 0
        return mainClassEntity
    }
    
    private func createWeatherEntityFrom(weather: Weather?) -> WeatherEntity? {
        guard
            let id = weather?.id,
            let icon = weather?.icon,
            let main = weather?.main,
            let desc = weather?.desc
        else {
            return nil
        }
        
        let weatherEntity = WeatherEntity(context: self.managedObjectContext)
        weatherEntity.id = Int64(id)
        weatherEntity.main = main
        weatherEntity.desc = desc
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

final class WeatherModelEntityObject: NSSecureCoding {
    static var supportsSecureCoding = true
    func encode(with coder: NSCoder) {}
    init?(coder: NSCoder) {}
}

// 1. Subclass from `NSSecureUnarchiveFromDataTransformer`
@objc(WeatherModelEntityValueTransformer)
final class WeatherModelEntityTransformer: NSSecureUnarchiveFromDataTransformer {

    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: WeatherModelEntityTransformer.self))

    override static var allowedTopLevelClasses: [AnyClass] {
        return [WeatherModel.self, Weather.self, List.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = WeatherModelEntityTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
