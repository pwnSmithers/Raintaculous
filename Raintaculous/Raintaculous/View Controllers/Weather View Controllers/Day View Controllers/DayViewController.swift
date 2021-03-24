//
//  DayViewController.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import UIKit

final class DayViewController: UIViewController {

    //MARK:- properties
    var viewModel: DayViewModel? {
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }
    
    //MARK:- outlets
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
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet var weatherDataViews: [UIView]! {
        didSet{
            for view in weatherDataViews {
                view.isHidden = true
            }
        }
    }
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.Raintaculous.lightBackgroundColor
    }
    
    private func setupViewModel(with viewModel: DayViewModel){
        activityIndicator.stopAnimating()
        humidityLabel.text = viewModel.humidity
        tempretureLabel.text = viewModel.temp
        windSpeedLabel.text = viewModel.wind
        descriptionLabel.text = viewModel.description
        iconImageView.image = viewModel.image
        timeLabel.text = viewModel.currentLoaction
        
        for view in weatherDataViews {
            view.isHidden = false
        }
    }

}
