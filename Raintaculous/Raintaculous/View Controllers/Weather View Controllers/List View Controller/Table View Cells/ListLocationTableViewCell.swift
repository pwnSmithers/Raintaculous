//
//  ListLocationTableViewCell.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import UIKit

class ListLocationTableViewCell: UITableViewCell {
    //MARK:- properties
    static var reuseidentifier: String {
        return String(describing: self)
    }
    
    //MARK:- Outlets
    @IBOutlet var locationName: UILabel! {
        didSet{
            locationName.font = UIFont.Raintaculous.lightRegular
        }
    }
    
    @IBOutlet var locationCoordinates: UILabel! {
        didSet{
            locationCoordinates.font = UIFont.Raintaculous.lightSmall
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
