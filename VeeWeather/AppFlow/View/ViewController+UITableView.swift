//
//  ViewController+UITableView.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let viewModel = viewModel,
            let array = viewModel.retriveDataFromCoreData(dataStore: self.dataStore)
        else { return 0 }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = weatherTableView.dequeueReusableCell(withIdentifier: WeekDataTableViewCell.reuseIdentifier) as? WeekDataTableViewCell,
            let viewModel = viewModel,
            let dict = viewModel.retriveDataFromCoreData(dataStore: self.dataStore)
        else {
            return UITableViewCell()
        }
        cell.configureCell(with: indexPath, dict: dict)
        
        return cell
    }
    
    
}
