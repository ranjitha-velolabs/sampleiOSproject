//
//  ViewController.swift
//  Skyshare_ios
//
//  Created by Ranjitha on 9/21/16.
//  Copyright © 2016 Ranjitha. All rights reserved.
//

import UIKit
import Mapbox


class ViewController: UIViewController, MGLMapViewDelegate{

    var mydict = [String:String]()
    var list = [String]() as NSArray
    

    @IBOutlet var mapView: MGLMapView!
    var text :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.lightStyleURL(withVersion: 9))
        mapView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        mapView.tintColor = .darkGray
        mapView.userTrackingMode = .follow
        view.addSubview(mapView)
        // Set the map view‘s delegate property
        mapView.delegate = self
        
        
        if let path = Bundle.main.path(forResource: "Json", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    if let people : [NSDictionary] = jsonResult["person"] as? [NSDictionary] {
                    let myBoard: NSArray = jsonResult["person"] as! NSArray
                     print(myBoard)
                     list = myBoard;
                        
                        for person: NSDictionary in people {
                            for (name,value) in person {
                                print("\(name) , \(value)")
                            }
                        }
                    }
                } catch {}
            } catch {}
        }
    }
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        // get the custom reuse identifier for this annotation
        let reuseIdentifier = reuseIdentifierForAnnotation(annotation)
        // try to reuse an existing annotation image, if it exists
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier)
        
        // if the annotation image hasn‘t been used yet, initialize it here with the reuse identifier
        if annotationImage == nil {
            // lookup the image for this annotation
            let image = imageForAnnotation(annotation)
            annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
        }
        
        return annotationImage
    }
    
    // create a reuse identifier string by concatenating the annotation coordinate, title, subtitle
    func reuseIdentifierForAnnotation(_ annotation: MGLAnnotation) -> String {
        var reuseIdentifier = "\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
        if let title = annotation.title , title != nil {
            reuseIdentifier += title!
        }
        return reuseIdentifier
    }
    
    // lookup the image to load by switching on the annotation's title string
    func imageForAnnotation(_ annotation: MGLAnnotation) -> UIImage {
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
    
    @IBAction func selectAction(_ sender: AnyObject) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListDetailsViewController") as! ListDetailsViewController
        secondViewController.listDetailsArray = list;
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool
    {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
    //override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        //let nav = self.navigationController?.navigationBar
        //nav?.barStyle = UIBarStyle.default
        //nav?.tintColor = UIColor.white
        //nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
    //}
}

