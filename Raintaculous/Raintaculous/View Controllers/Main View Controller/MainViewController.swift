//
//  MainViewController.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import UIKit

final class MainViewController: UIViewController {
    private enum AlertType{
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }

    //MARK:- Properties
    var viewModel: MainViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
            setupForecastViewModel(with: viewModel)
        }
    }
    
    private let dayViewController: DayViewController = {
        if #available(iOS 13.0, *) {
            guard let dayViewController = UIStoryboard.main.instantiateViewController(identifier: DayViewController.storyboardIdentifier) as? DayViewController else {
                fatalError("Unable to instiate Day View Controller")
            }
            dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
            return dayViewController
        } else {
            // Fallback on earlier versions
            guard let dayViewController = UIStoryboard.main.instantiateViewController(withIdentifier: DayViewController.storyboardIdentifier) as? DayViewController else {
                fatalError("Unable to instiate Day View Controller")
            }
            dayViewController.view.translatesAutoresizingMaskIntoConstraints = false
            return dayViewController
        }
        //Configure day view controller
        
    }()
    
    private let weekViewController: WeekViewController = {
        if #available(iOS 13.0, *) {
            guard let weekViewController = UIStoryboard.main.instantiateViewController(identifier: WeekViewController.storyboardIdentifier) as? WeekViewController else {
                fatalError("Unable to instiate Week View Controller")
            }
            weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
            return weekViewController
        } else {
            // Fallback on earlier versions
            guard let weekViewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.storyboardIdentifier) as? WeekViewController else {
                fatalError("Unable to instiate Week View Controller")
            }
            weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
            return weekViewController
        }
   
    }()
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //setup child view controllers
        setupChildViewControllers()
        
    }

    private func setupChildViewControllers() {
        addChild(dayViewController)
        addChild(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        dayViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dayViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dayViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
  
        
        weekViewController.view.topAnchor.constraint(equalTo: dayViewController.view.bottomAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    

    private func setupViewModel(with viewModel: MainViewModel) {
        viewModel.didFetchCurrentWeatherData = {[weak self] (result) in
            switch result {
            case .success(let weatherData):
                let dayViewModel = DayViewModel(currentWeatherData: weatherData.current, currentWind: weatherData.currentWind, todaysWeather: weatherData.currentWeather, currentLoaction: weatherData.locationName)
                self?.dayViewController.viewModel = dayViewModel
            case .failure(let error):
            let alertType: AlertType
            switch error {
            case .notAuthorizedToRequestLocation:
                alertType = .notAuthorizedToRequestLocation
            case .noWeatherDataAvailable:
                alertType = .noWeatherDataAvailable
            case .failedToRequestLocation:
                alertType = .failedToRequestLocation
            }
            self?.presentAlert(of: alertType)
            }
        }
    }
    
    private func setupForecastViewModel(with viewModel: MainViewModel) {
        viewModel.didFetchForecastWeatherData = {[weak self] (result) in
            switch result {
            case .success(let weatherData):
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                self?.weekViewController.viewModel = weekViewModel
            case .failure(_):
                self?.presentAlert(of: .noWeatherDataAvailable)
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        let title: String
        let message: String
        
        switch alertType {
        case .noWeatherDataAvailable:
            title = "Unable to fetch weather data"
            message = "The application is unable to fetch weather data. Please make sure your device is connected over wifi or cellular"
        case .notAuthorizedToRequestLocation:
            title = "Unable to fetch wether data for your location"
            message = "Raintaculous is not authorized to access your current location. This means it's unable to show you your current location. You can grant Raintaculous access to current location in the settings application."
        case .failedToRequestLocation:
            title = "Unable to fetch weather data"
            message = "The application is unable to fetch your location. Please make sure your device is connected over wi-fi or cellular."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
