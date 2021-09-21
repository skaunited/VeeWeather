//
//  WeekDataTableViewCell.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//

import UIKit

class WeekDataTableViewCell: UITableViewCell {

    struct K {
        static let defaultWebServiceDateFormatter = "yyyy-MM-dd HH:mm:ss"
        static let exportDateFormatter = "EEEE"
    }
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var tempIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with indexPath: IndexPath, dict : [DateComponents: [ListEntity]] ) {
        
        let dictValInc = dict.sorted { ($0.key.year!,$0.key.month! ,$0.key.day!) < ($1.key.year!, $1.key.month!,$1.key.day!) }
        let dateString = dictValInc[indexPath.row].value[0].dtTxt
        self.day.text = convertDatStringToCustomString(baseFormatter: K.defaultWebServiceDateFormatter,
                                                       exportFormatter: K.exportDateFormatter,
                                                       dtString: dateString)
        
        let mainEntity: MainClassEntity? = dictValInc[indexPath.row].value[0].main
        if let temp = mainEntity?.temp {
            self.temperature.text = "\(convertKelvinToCelsius(digits: 0, number: temp))°"
        }
                
        if let entity = dictValInc[indexPath.row].value[0].weather {
            DispatchQueue.main.async {
                self.tempIcon.image = UIImage(named: entity.icon.orEmpty)
            }
        }
    }


}
