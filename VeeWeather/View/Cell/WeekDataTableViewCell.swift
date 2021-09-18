//
//  WeekDataTableViewCell.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//

import UIKit

class WeekDataTableViewCell: UITableViewCell {

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

}
