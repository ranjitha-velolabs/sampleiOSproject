//
//  ViewController.swift
//  MapboxApp
//
//  Created by IndiaTeam on 28/07/16.
//  Copyright © 2016 IndiaTeam. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController , MGLMapViewDelegate{


    @IBOutlet var mapView: MGLMapView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.outdoorsStyleURLWithVersion(9))
        
        mapView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
        mapView.tintColor = .darkGrayColor()
        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: 37.773972, longitude: -122.431297), zoomLevel: 5, animated: false)
        view.addSubview(mapView)
        mapView.delegate = self
        
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 37.773972, longitude: -122.431297)
        point.title = "USA"
        point.subtitle = "Sanfrancisco"
        mapView.addAnnotation(point)
    
        
    }
   
    func mapView(mapView: MGLMapView, viewForAnnotation annotation: MGLAnnotation) -> MGLAnnotationView? {

        return nil
    }

    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


