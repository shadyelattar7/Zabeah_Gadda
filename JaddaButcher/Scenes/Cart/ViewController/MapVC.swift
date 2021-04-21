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
    private var mapChangedFromUserInteraction = false

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
        
        checkLocationService()
        self.mapView.delegate = self
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
            opensettingToUser()
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            opensettingToUser()
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
    
  
    
    fileprivate func opensettingToUser()
    {
        
        
        let enableLocation = UIAlertController(title: "توجه", message: "يرجي السماح بتحديد الموضع من الاعدادات هل تريد التوجه للاعدادات ؟", preferredStyle: UIAlertController.Style.alert)
        
        enableLocation.addAction(UIAlertAction(title: "تم", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
            
        }))
        
        enableLocation.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        present(enableLocation, animated: true, completion: nil)
        
        return
    }
    
    @IBAction func confAddress(_ sender: Any) {
        print("Back")
        
        guard let lat: Double = self.latitude , lat != 0.0 , let long: Double = self.longitude , long != 0.0 else {
            self.showAlart(title: "", message: "برجاء اختيار الموقع")
            return
        }
        
        
        
        self.delegate.userLocation(latitude: self.latitude, longitude: self.longitude)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func currentLocation_btn(_ sender: Any) {
        checkLocationService()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
        mapView.setRegion(region, animated: true)
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        //  cameraMoveToLocation(toLocation: locValue)
        print("Current Location: \(locValue.latitude) , \(locValue.longitude)")
        
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}


extension MapVC: CLLocationManagerDelegate{
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            guard let location = locations.last else {return}
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
//            mapView.setRegion(region, animated: true)
//
//            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
//              //  cameraMoveToLocation(toLocation: locValue)
//            print("Current Location: \(locValue.latitude) , \(locValue.longitude)")
//
//            self.latitude = locValue.latitude
//            self.longitude = locValue.longitude
//
//            locationManager.stopUpdatingLocation()
//        }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {return}
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
//        mapView.setRegion(region, animated: true)
//
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
//          //  cameraMoveToLocation(toLocation: locValue)
//        print("Current Location: \(locValue.latitude) , \(locValue.longitude)")
//
//        self.latitude = locValue.latitude
//        self.longitude = locValue.longitude
//
//        locationManager.stopUpdatingLocation()
//    }

//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
//    }

}
extension MapVC: MKMapViewDelegate{
    private func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapView.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == UIGestureRecognizer.State.began || recognizer.state == UIGestureRecognizer.State.ended ) {
                    return true
                }
            }
        }
        return false
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapChangedFromUserInteraction = mapViewRegionDidChangeFromUserInteraction()
        if (mapChangedFromUserInteraction) {
            // user will change map region
            print("user WILL change map.")
            
//            // calculate the width of the map in miles.
//            let mRect: MKMapRect = mapView.visibleMapRect
//            let eastMapPoint = MKMapPointMake(mRect.minX, mRect.midY)
//            let westMapPoint = MKMapPointMake(mRect.maxX, mRect.midY)
//            let currentDistWideInMeters = eastMapPoint.distance(to: westMapPoint)
//            let milesWide = currentDistWideInMeters / 1609.34  // number of meters in a mile
//            print(milesWide)
//            print("^miles wide")
//
//            // check if user zoomed in too far and zoom them out.
//            if milesWide < 2.0 {
//                var region:MKCoordinateRegion = mapView.region
//                var span:MKCoordinateSpan = mapView.region.span
//                span.latitudeDelta = 0.04
//                span.longitudeDelta = 0.04
//                region.span = span;
//                mapView.setRegion(region, animated: true)
//                print("map zoomed back out")
//            }
            
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if (mapChangedFromUserInteraction) {
            // user changed map region
            print("user CHANGED map.")
//            print(mapView.region.span.latitudeDelta)
//            print(mapView.region.span.longitudeDelta)
            
            print(mapView.region.center.latitude)
            print(mapView.region.center.longitude)
            
            self.latitude = mapView.region.center.latitude
            self.longitude = mapView.region.center.longitude
            
            
//            // calculate the width of the map in miles.
//            let mRect: MKMapRect = mapView.visibleMapRect
//            let eastMapPoint = MKMapPointMake(mRect.minX, mRect.midY)
//            let westMapPoint = MKMapPointMake(mRect.maxX, mRect.midY)
//            let currentDistWideInMeters = eastMapPoint.distance(to: westMapPoint)
//            let milesWide = currentDistWideInMeters / 1609.34  // number of meters in a mile
//            print(milesWide)
//            print("^miles wide")
//
//            // check if user zoomed in too far and zoom them out.
//            if milesWide < 2.0 {
//                var region:MKCoordinateRegion = mapView.region
//                var span:MKCoordinateSpan = mapView.region.span
//                span.latitudeDelta = 0.04
//                span.longitudeDelta = 0.04
//                region.span = span;
//                mapView.setRegion(region, animated: true)
//                print("map zoomed back out")
//            }
        }
    }
}
