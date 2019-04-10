//
//  ViewController.swift
//  Sport
//
//  Created by Amir on 4/4/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: UIViewController {
    
    var manager: CLLocationManager?
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
        
        checkLocationAuthStatus()
        mapView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }

}

extension BeginRunVC: MKMapViewDelegate{
    
    func checkLocationAuthStatus(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse || CLLocationManager.authorizationStatus() != .authorizedAlways{
            manager?.requestAlwaysAuthorization()
        }
    }
}

extension BeginRunVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways{
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}

