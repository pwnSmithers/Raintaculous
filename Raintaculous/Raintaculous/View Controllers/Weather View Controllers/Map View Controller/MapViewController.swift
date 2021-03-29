//
//  MapViewController.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    private enum AlertType{
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
        case savedLocation
        case howToSaveLocation
    }
    
    //MARK:- Properties
    var selectedAnnotation: MKPointAnnotation?
    var latitude: String = ""
    var longitude: String = ""
    let annotation = MKPointAnnotation()
    var viewModel: MapViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            setupView(with: viewModel)
        }
    }
 
    
    //MARK:- Outlets
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if #available(iOS 10.0, *){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //let mySceneDelegate = self.view.window?.windowScene?.delegate
            let context = appDelegate.persistentContainer.viewContext
            let location = Location(entity: Location.entity(), insertInto: context)
            location.latitude = latitude
            location.longitude = longitude
            appDelegate.saveContext()
            presentAlert(of: .savedLocation)
        } else {
            
        }
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MapViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentAlert(of: .howToSaveLocation)
    }
    

    //MARK:- PRIVATE METHODS
    private func setupView(with viewModel: MapViewModel) {
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecogniser)
        mapView.mapType = MKMapType.standard
        
        viewModel.didFetchCurrentLocationData = {[weak self] (result) in
            switch result {
            case .success(let location):
                let location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: location, span: span)
                self?.mapView.setRegion(region, animated: true)
                self?.annotation.coordinate = location
                if let annotation = self?.annotation{
                    self?.mapView.addAnnotation(annotation)
                }
                
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

    @objc private func handleTap(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        //Remove annotation
        mapView.removeAnnotation(annotation)
        
        //Add annotation
        annotation.coordinate = coordinate
        self.latitude = String(format: "%0.02f", annotation.coordinate.latitude)
        self.longitude = String(format: "%0.02f", annotation.coordinate.longitude)
        annotation.title = "Latitude:" + String(format: "%0.02f", annotation.coordinate.latitude) + "Longitude:" + String(format: "%0.02f", annotation.coordinate.longitude)
        mapView.addAnnotation(annotation)
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
        case .savedLocation:
            title = "location saved"
            message = "Successfully saved the location."
        case .howToSaveLocation:
            title = "How To Save a location"
            message = "Tap anywhere on the map and hold for 0.5 seconds, this will drop a pin on the selected position of choice. After selecting a location, tap the save button at the top to bookmark the location."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
