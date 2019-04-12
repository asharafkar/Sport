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
    @IBOutlet weak var lastRunView: UIView!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    

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
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    @IBAction func lastRunClosePressed(_ sender: UIButton) {
        lastRunView.isHidden = true
    }
    
    func getLastRun(){
        guard let run = Run.getAllRuns()?.first else {
            lastRunView.isHidden = true
            return
        }
        paceLabel.text = "میانگین سرعت: " + run.pace.formatTimeDurationToString()
        distanceLabel.text = "مسافت: " + "\(run.distance.metersToMiles()) mi"
        durationLabel.text = "مدت زمان: " + run.duration.formatTimeDurationToString()
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

