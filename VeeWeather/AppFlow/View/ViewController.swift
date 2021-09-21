//
//  ViewController.swift
//  VeeWeather
//
//  Created by Skander Bahri on 15/09/2021.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa
import CoreData

class ViewController: UIViewController {
    
    struct K {
        static var defaultCity = "Paris"
    }
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var addCountryButton: UIButton!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var tempState: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var city: UILabel!
    
    // MARK: - Global
    var viewModel: ViewControllerModelProtocol?
    var dataStore:DataStore!
    private let disposeBag = DisposeBag()

    var networkState: NetworkConnectionStatus = NetworkConnectionStatus.online {
        didSet {
            showAlertWith(message: "You got \(networkState.rawValue) data 🐳")
            setup()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ConnectivityMananger.shared().addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ConnectivityMananger.shared().removeListener(listener: self)
    }
    
    private func setupUI(){
        dataStore = DataStore(uiUpdater: self)
        dataStore.fetchedResultsController.delegate = self
        
        addCountryButton.layer.shadowColor = shadowColor.cgColor
        addCountryButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addCountryButton.layer.shadowRadius = 5
        addCountryButton.layer.shadowOpacity = 0.26
    }
    
    /// Rx Bind
    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.currentWeatherStateFinished.bind { [weak self] (weatherModel) in
            DispatchQueue.main.async {
                self?.currentTemp.text = weatherModel.currentTemp.orEmpty
                self?.tempState.text = weatherModel.weatherState.orEmpty
            }
        }.disposed(by: disposeBag)
        
        viewModel.currentCityFinished.bind { [weak self] (cityEntity) in
            DispatchQueue.main.async {
                self?.city.text = cityEntity?.first?.name.orEmpty.uppercased()
            }
        }.disposed(by: disposeBag)
    }
    
    private func setupTableView(){
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
    }

    private func setup(){
        guard let viewModel = viewModel else { return }
        switch networkState {
        case .online:
            viewModel.fetchWeatherData(dataStore: self.dataStore, city: K.defaultCity)
        default:
            updateUI()
        }
    }
    private func afterSetup(){
        guard
            let viewModel = viewModel,
            let dict = viewModel.retriveDataFromCoreData(dataStore: self.dataStore)
        else
        { return }
        
        viewModel.fetchTheCurrentWeatherState(dict: dict)
        viewModel.retriveCityDataFromCoreData(dataStore: self.dataStore)
        weatherTableView.reloadData()
    }
    @IBAction func addNewCity(_ sender: UIButton) {
        presentAddCityAlert()
    }
}

extension ViewController: UIUpdaterProtocol, NSFetchedResultsControllerDelegate {
    
    func updateUI() {
        dataStore.getDataFromDB()
        weatherTableView.reloadData()
        afterSetup()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // Start Update
        weatherTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                weatherTableView.insertRows(at: [indexPath], with: .middle)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                weatherTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        default:
            break;
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            weatherTableView.insertSections(IndexSet(integer: sectionIndex), with: .middle)
        case .delete:
            weatherTableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            break;
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // End update
        weatherTableView.endUpdates()
    }
}

extension ViewController: NetworkConnectionStatusListener {
    func networkStatusDidChange(status: NetworkConnectionStatus) {
        switch status {
        case .offline:
            self.networkState = .offline
        case .online:
            self.networkState = .online
        }
    }
    
    func showAlertWith(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) {(_) in
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAddCityAlert(){
        let alertController = UIAlertController(title: "Add new city", message: "If you are in online mode you might add a new city to your wish weather list", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Saint-Riquier"
            textField.isSecureTextEntry = false
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            K.defaultCity = textField.text.orEmpty
            self.viewDidLoad()
            self.networkState = NetworkConnectionStatus.online
            log.info("Default city did changed --> \(String(describing: textField.text))")
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

