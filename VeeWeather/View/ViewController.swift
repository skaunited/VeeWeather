//
//  ViewController.swift
//  VeeWeather
//
//  Created by Skander Bahri on 15/09/2021.
//

import UIKit
import Swinject




class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var addCountryButton: UIButton!
    // MARK: - Global
    var viewModel: ViewControllerModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel?.getDebugTest()
        setupUI()
    }

    
    private func setupUI(){
        addCountryButton.layer.shadowColor = shadowColor.cgColor
        addCountryButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addCountryButton.layer.shadowRadius = 5
        addCountryButton.layer.shadowOpacity = 0.26
    }

}

