//
//  ViewController.swift
//  MapboxWithLocation
//
//  Created by IndiaTeam on 22/08/16.
//  Copyright © 2016 IndiaTeam. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController , MGLMapViewDelegate{

    @IBOutlet var mapView: MGLMapView!
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.lightStyleURLWithVersion(9))
        mapView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
        mapView.tintColor = .darkGrayColor()
        mapView.userTrackingMode = .Follow                 
    
        // Set the map's bounds
        //let bounds = MGLCoordinateBounds(sw: CLLocationCoordinate2D(latitude: 37.732284, longitude: -122.465976),
                                         //ne: CLLocationCoordinate2D(latitude: 37.788197, longitude: -122.394136))
        //mapView.setVisibleCoordinateBounds(bounds, animated: false)
        
        view.addSubview(mapView)
        
        // Set the map view‘s delegate property
        mapView.delegate = self
        
         // Initialize and add the point annotation.
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2DMake(37.773972,-122.431297)
        point.title = "USA"
        point.subtitle = "SanFrancisco"
        mapView.addAnnotation(point)
        }
    
       func mapView(mapView: MGLMapView ,imageForAnnotation annotation: MGLAnnotation)-> MGLAnnotationImage?
       {
        //To reuse the existing ‘point’ annotation image, if it exists.
        var annotationImage = mapView.dequeueReusableAnnotationImageWithIdentifier("point")
        if annotationImage == nil
        {
         var image = UIImage(named: "marker")
            image = image!.imageWithAlignmentRectInsets(UIEdgeInsetsMake(0, 0, (image!.size.height)/2, 0))
            
          // Initialize the ‘point’ annotation image with the UIImage we just loaded.
            annotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: "point")
        }
        return annotationImage
      }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool
    {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

