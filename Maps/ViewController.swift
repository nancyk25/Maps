//
//  ViewController.swift
//  Maps
//
//  Created by Nancy Kim on 11/9/14.
//  Copyright (c) 2014 Udemy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    
    var manager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.
        
        
//Core Location
        
        manager.delegate = self  //manager is delegated by ViewController
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
// Find location/region: My House! (33.962831, -118.125309)
        
        var latitude: CLLocationDegrees = 33.962831
        
        var longitude: CLLocationDegrees = -118.125309
        
        //zooming of points
        
        var latDelta: CLLocationDegrees = 0.01 // the bigger the more zoomed out
        
        var lonDelta: CLLocationDegrees = 0.01
        
        //spands range according to zoom ^
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake (latDelta, lonDelta)
        
        //**location of coordinates in 2D
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake (latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake (location, span)
        
        myMap.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation ()
        
        annotation.coordinate = location
        
        annotation.title = "My House"
        
        annotation.subtitle = "I live here!"
        
        myMap.addAnnotation(annotation)
        
        //create a variable
        
        var uilpgr = UILongPressGestureRecognizer (target: self, action: "action:")
        
        // how long  - function to call by uilpgr initated by action: < parameters in function (x)
        
        uilpgr.minimumPressDuration = 1.0
        
        //adds pin
        myMap.addGestureRecognizer(uilpgr)
    }
    
//function to recognize a touch point and put a pin on newCoordinate
    
    func action(gestureRecognizer:UIGestureRecognizer) {
            //This says gestureRec is passed by UIGestureRec ^
        
        println("test")
        
        var touchPoint = gestureRecognizer.locationInView(self.myMap)
            //Where the user touched the screen. Need to call self because we're within a func and load myMap as current view
        
        var newCoordinate: CLLocationCoordinate2D = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
            //Where that touchpoint coordinate is
        
        var newAnnotation = MKPointAnnotation()
        
        newAnnotation.coordinate = newCoordinate
        
        newAnnotation.title = "Park here"
        
        newAnnotation.subtitle = "Dock address"
        
        myMap.addAnnotation(newAnnotation)
        
    
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]){
        
        println("locations = \(locations)")
        
        var userLocation: CLLocation = locations[0] as CLLocation
        
        var latitude: CLLocationDegrees = userLocation.coordinate.latitude
        
        var longitude: CLLocationDegrees = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.01 // the bigger the more zoomed out
        
        var lonDelta: CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake (latDelta, lonDelta)
                
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake (latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake (location, span)
        
        myMap.setRegion(region, animated: true)
    }
   
    func locationManager(manager:CLLocationManager, didFailWithError error:NSError)
    {
        println(error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

