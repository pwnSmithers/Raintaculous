//
//  RootViewController.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import UIKit

final class RootViewController: UIViewController {
    private enum AlertType{
        case noWeatherDataAvailable
    }

    //MARK:- Properties
    var viewModel: RootViewModel? {
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
    

    private func setupViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchCurrentWeatherData = {[weak self] (weatherData, error) in
            if let _ = error {
                self?.presentAlert(of: .noWeatherDataAvailable)
            } else if let weatherData = weatherData {
                let dayViewModel = DayViewModel(currentWeatherData: weatherData.current, currentWind: weatherData.currentWind, todaysWeather: weatherData.currentWeather)
                self?.dayViewController.viewModel = dayViewModel
            } else {
                self?.presentAlert(of: .noWeatherDataAvailable)
            }
        }
    }
    
    private func setupForecastViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchForecastWeatherData = {[weak self] (weatherData, error) in
            if let _ = error {
                self?.presentAlert(of: .noWeatherDataAvailable)
            } else if let weatherData = weatherData {
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                self?.weekViewController.viewModel = weekViewModel
            } else {
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
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
