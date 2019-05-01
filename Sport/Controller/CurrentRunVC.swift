//
//  CurrentRunVC.swift
//  Sport
//
//  Created by Amir on 4/5/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class CurrentRunVC: UIViewController, UIGestureRecognizerDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var swipeBGImageView: UIImageView!
    @IBOutlet weak var sliderButton: UIButton!
    var manager: CLLocationManager?
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var counter: Int = 0
    var timer = Timer()
    var pace = 0
    var runDistance = 0.0
    fileprivate var locations = List<Location>()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    
    func startRun(){
        manager?.startUpdatingLocation()
        startTimer()
        pauseButton.setImage(UIImage(named: "pauseButton"), for: .normal)
    }
    
    func startTimer(){
        durationLabel.text = counter.formatTimeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter(){
        counter += 1
        durationLabel.text = counter.formatTimeDurationToString()
    }
    
    func calculatePace(time seconds: Int, miles: Double) -> String{
        pace = Int(Double(seconds) / miles)
        return pace.formatTimeDurationToString()
    }
    
    func stopRun(){
        manager?.stopUpdatingLocation()
        Run.addRunToRealm(pace: pace, distance: runDistance, duration: counter, locations: locations)
    }
    
    func pauseRun(){
        startLocation = nil
        lastLocation = nil
        timer.invalidate()
        manager?.stopUpdatingLocation()
        pauseButton.setImage(UIImage(named: "resumeButton"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderButton.addGestureRecognizer(swipeGesture)
        sliderButton.isUserInteractionEnabled = true
        swipeGesture.delegate = self
        
        print(Run.getAllRuns())
        print("")
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        if timer.isValid{
            pauseRun()
        }else{
            startRun()
        }
    }
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer){
        let minAdjust: CGFloat = 62
        let maxAdjust: CGFloat = 110
        if let sliderView = sender.view{
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIPanGestureRecognizer.State.changed{
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBGImageView.center.x - minAdjust) && sliderView.center.x <= (swipeBGImageView.center.x + maxAdjust){
                    sliderView.center.x = sliderView.center.x + translation.x
                }else if sliderView.center.x >= (swipeBGImageView.center.x + maxAdjust){
                    sliderView.center.x = swipeBGImageView.center.x + maxAdjust
                    stopRun()
                    dismiss(animated: true, completion: nil)
                }else{
                    sliderView.center.x = swipeBGImageView.center.x - minAdjust
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            }else if sender.state == UIPanGestureRecognizer.State.ended{
                UIView.animate(withDuration: 0.1, animations: {
                    sliderView.center.x = self.swipeBGImageView.center.x - minAdjust
                })
            }
        }
    }
    
    func checkLocationAuthStatus(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse || CLLocationManager.authorizationStatus() != .authorizedAlways{
            manager?.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways{
            checkLocationAuthStatus()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if startLocation == nil{
            startLocation = locations.first
        }else if let location = locations.last{
            let newLocation = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.locations.insert(newLocation, at: 0)
            print(self.locations.count)
            runDistance += lastLocation.distance(from: location)
            distanceLabel.text = "\(runDistance.metersToMiles(places: 1))"
            if counter > 0 && runDistance > 0{
                paceLabel.text = calculatePace(time: counter, miles: runDistance.metersToMiles(places: 2))
            }
        }
        lastLocation = locations.last
    }
    
}
