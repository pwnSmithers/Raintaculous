//
//  WeekDayTableViewCell.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {

    //MARK:- Properties
    static var reuseidentifier: String {
        return String(describing: self)
    }
    
    @IBOutlet var humidityLabel: UILabel! {
        didSet {
            humidityLabel.textColor = UIColor.Raintaculous.base
            humidityLabel.font = UIFont.Raintaculous.heavyLarge
        }
    }
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.Raintaculous.base
        }
    }
    
    @IBOutlet var tempretureLabel: UILabel!
    
    @IBOutlet var windSpeedLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var regularLabels: [UILabel]! {
        didSet{
            for label in regularLabels{
                label.textColor = .black
                label.font = UIFont.Raintaculous.lightRegular
            }
        }
    }
    
    @IBOutlet var smallLabels: [UILabel]! {
        didSet {
            for label in smallLabels {
                label.textColor = .black
                label.font = UIFont.Raintaculous.lightSmall
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }


    
    func configure(with representable: WeekDayRepresentable) {
        humidityLabel.text = representable.humidity
        descriptionLabel.text = representable.description
        tempretureLabel.text = representable.tempreture
        iconImageView.image = representable.image
        windSpeedLabel.text = representable.windSpeed
    }

}
