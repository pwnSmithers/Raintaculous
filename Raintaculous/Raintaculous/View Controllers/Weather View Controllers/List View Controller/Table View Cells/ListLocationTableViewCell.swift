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
    
    var viewModel: ListCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
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
    
    private func setupViewModel(with viewModel: ListCellViewModel){
        viewModel.didFetchCurrentCityName = {[weak self] (result) in
            switch result {
            case .success(let name):
                self?.locationName.text = name.name
            case .failure(let error):
                print("handle this error \(error)")
            }
        }
        self.locationCoordinates.text = "Lat: \(String(viewModel.location.latitude)) Lon: \( viewModel.location.longitude)"
    }
    

}
