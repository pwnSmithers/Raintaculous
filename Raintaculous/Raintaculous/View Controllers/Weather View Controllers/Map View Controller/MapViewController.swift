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
    
    //MARK:- Outlets
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    //MARK:- PRIVATE METHODS
    private func setupView() {
        mapView.delegate = self
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecogniser)
        mapView.mapType = MKMapType.standard
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(38.8977), longitude: CLLocationDegrees(-77.0365))
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        //setupNavBar
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: nil)
        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365)
//        mapView.addAnnotation(annotation)
//
//        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//        mapView.setRegion(region, animated: true)
    }
    
    @objc private func handleTap(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        //Add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Latitude:" + String(format: "%0.02f", annotation.coordinate.latitude) + "Longitude:" + String(format: "%0.02f", annotation.coordinate.longitude)
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let latValue: String = String(format: "%.02f", Float((view.annotation?.coordinate.latitude)!))
        let longValue: String = String(format: "%.02f", Float((view.annotation?.coordinate.longitude)!))
        print("Latitude \(latValue) Longitude \(longValue)")
    }
}
