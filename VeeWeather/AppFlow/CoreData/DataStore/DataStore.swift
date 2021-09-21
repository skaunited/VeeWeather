//
//  DataStore.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//

import Foundation
import CoreData

protocol UIUpdaterProtocol: class {
    func updateUI()
}

class DataStore: NSObject {
    let networkManager:NetworkManagerProtocol!
    let coreDataManager = CoreDataManager.sharedInstance
    private weak var uiUpdater:UIUpdaterProtocol!
    
    struct K {
        static let entityName = "ListEntity"
        static let entityKey = "dt"
        static let defaultCity = "Paris, FR"
    }
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: K.entityKey, ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.managedObjectContext, sectionNameKeyPath: #keyPath(ListEntity.dt), cacheName: nil)
        return frc
    }()
    
    init(with netWorkManager:NetworkManagerProtocol = NetworkDataManager.shared(), uiUpdater: UIUpdaterProtocol){
        self.networkManager = netWorkManager
        self.uiUpdater = uiUpdater
        super.init()
    }
    
    // fetch The data
    func fetchWeatherData(city: String?){
        networkManager.getWeatherData(city: city ?? K.defaultCity) { (result) in
            switch result {
            case.success(let weatherModel):
                self.coreDataManager.deleteData()
                self.coreDataManager.prepare(dataForSaving: weatherModel)
                self.uiUpdater.updateUI()
            case.failure(let error):
                self.uiUpdater.updateUI()
                log.error("Failed to fetch data from web service ==> \(error)")
            }
        }
    }
    
    func getDataFromDB(){
        do{
            try fetchedResultsController.performFetch()
        }catch(let ex){
            
            print(ex.localizedDescription)
        }
    }
    
}
