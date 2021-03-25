//
//  MapViewController.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK:- Properties
    var selectedAnnotation: MKPointAnnotation?
    var latitude: String = ""
    var longitude: String = ""
    let annotation = MKPointAnnotation()
    
    //MARK:- Outlets
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBAction func saveButtonAction(_ sender: Any) {
        print("Save location")
        if #available(iOS 10.0, *){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //let mySceneDelegate = self.view.window?.windowScene?.delegate
            let context = appDelegate.persistentContainer.viewContext
            let location = Location(entity: Location.entity(), insertInto: context)
            location.latitude = latitude
            location.longitude = longitude
            appDelegate.saveContext()
        } else {
            
        }
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    //MARK:- PRIVATE METHODS
    private func setupView() {
        //mapView.delegate = self
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecogniser)
        mapView.mapType = MKMapType.standard
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(38.8977), longitude: CLLocationDegrees(-77.0365))
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
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
}

//extension MapViewController: MKMapViewDelegate{
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        let latValue: String = String(format: "%.02f", Float((view.annotation?.coordinate.latitude)!))
//        let longValue: String = String(format: "%.02f", Float((view.annotation?.coordinate.longitude)!))
//        self.latitude = latValue
//        self.longitude = longValue
//        print("Latitude \(latValue) Longitude \(longValue)")
//    }
//}
