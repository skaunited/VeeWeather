//
//  ViewController.swift
//  VeeWeather
//
//  Created by Skander Bahri on 15/09/2021.
//

import UIKit
import Swinject




class ViewController: UIViewController {

    // MARK: - Global
    var viewModel: ViewControllerModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel?.getDebugTest()
    }


}

