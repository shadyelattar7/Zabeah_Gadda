//
//  MapVC.swift
//  City Butcher
//
//  Created by Elattar on 12/7/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


protocol  coordinateLocation: class {
    func userLocation (latitude: Double, longitude: Double)
}

class MapVC: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var current_btn: UIButton!
    @IBOutlet weak var confAddress_btn: UIButton!
    
    let regionInMeter: Double = 10000
    let locationManager = CLLocationManager()
    
    var latitude = 0.0
    var longitude = 0.0
    
     weak var delegate: coordinateLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView(){
         navigationItem.hidesBackButton = true
        self.title = "اختيار العنوان"

        
        
        current_btn.layer.cornerRadius = 8
        confAddress_btn.layer.cornerRadius = 8
        
        
    }
    
    private func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    private func setupLoactionManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    private func checkLocationService(){
        if CLLocationManager.locationServicesEnabled(){
            setupLoactionManager()
            checkLocationAuthorization()
        }else{

        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            print("error")
        }
    }


    @IBAction func confAddress(_ sender: Any) {
        print("Back")
        guard let lat: Double = self.latitude , lat != 0.0 , let long: Double = self.longitude , long != 0.0 else {
            self.showAlart(title: "خطا", message: "برجاء اختيار الموقع")
            return
        }
        self.delegate.userLocation(latitude: self.latitude, longitude: self.longitude)

        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func currentLocation_btn(_ sender: Any) {
        checkLocationService()
    }
    
}


extension MapVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
        mapView.setRegion(region, animated: true)
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        //    cameraMoveToLocation(toLocation: locValue)
        print("Current Location: \(locValue.latitude) , \(locValue.longitude)")
        
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}
