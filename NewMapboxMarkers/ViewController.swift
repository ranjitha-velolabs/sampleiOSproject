//
//  ViewController.swift
//  NewMapbox
//
//  Created by IndiaTeam on 05/09/16.
//  Copyright © 2016 IndiaTeam. All rights reserved.
//

import UIKit
import Mapbox
import Alamofire

class ViewController: UIViewController, MGLMapViewDelegate{
    
    @IBOutlet var mapView: MGLMapView!
        var text :String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.lightStyleURLWithVersion(9))
        mapView.autoresizingMask = [.FlexibleWidth , .FlexibleHeight]
        mapView.tintColor = .darkGrayColor()
        mapView.userTrackingMode = .Follow
        view.addSubview(mapView)
        
        // Set the map view‘s delegate property
        mapView.delegate = self
        
        Alamofire.request(.GET, "https://rawgit.com/aravind741/HerokuTest/master/geojson.json").responseJSON
            { ( response) -> Void in
                if let json = response.result.value{
                    
                    let features = json["features"]
                    for item in features as![AnyObject]
                    {
                        
                        let latitude = item.objectForKey("geometry")!.objectForKey("coordinates")![1] as! Double
                        let longitude =  item.objectForKey("geometry")!.objectForKey("coordinates")![0] as! Double
                        // Initialize and add the point annotation.
                        let point = MGLPointAnnotation()
                        point.coordinate = CLLocationCoordinate2DMake(latitude,longitude)
                        point.title = item.objectForKey("properties")!.objectForKey("title") as? String
                        self.text = (item.objectForKey("properties")!.objectForKey("imageName") as? String)!
                        mapView.addAnnotation(point)

                    }
                  }
        }
        
        
    }
    
    
    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage? {
        // get the custom reuse identifier for this annotation
        let reuseIdentifier = reuseIdentifierForAnnotation(annotation)
        // try to reuse an existing annotation image, if it exists
        var annotationImage = mapView.dequeueReusableAnnotationImageWithIdentifier(reuseIdentifier)
        
        // if the annotation image hasn‘t been used yet, initialize it here with the reuse identifier
        if annotationImage == nil {
            // lookup the image for this annotation
            let image = imageForAnnotation(annotation)
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
        }
        
        return annotationImage
    }
    
    // create a reuse identifier string by concatenating the annotation coordinate, title, subtitle
    func reuseIdentifierForAnnotation(annotation: MGLAnnotation) -> String {
        var reuseIdentifier = "\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
        if let title = annotation.title where title != nil {
            reuseIdentifier += title!
        }
        return reuseIdentifier
    }
    
    // lookup the image to load by switching on the annotation's title string
    func imageForAnnotation(annotation: MGLAnnotation) -> UIImage {
        var imageName = ""
        
        print(text)
        switch text {
        case "cycle":
            imageName = "cycle"
        case "marker":
            imageName = "marker"
        case "red-cycle":
            imageName = "red-cycle"
        case "yellow-cycle":
            imageName = "yellow-cycle"
        case "black-cycle":
            imageName = "black-cycle"
        case "green":
            imageName = "green"
        default:
            imageName = ""
        }
        
        return UIImage(named: imageName)!
    }
    
    
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool
    {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
}
