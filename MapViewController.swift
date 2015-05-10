//
//  MapViewController.swift
//  ActiveMeetings
//
//  Created by Janusz Marcinkiewicz on 10.05.2015.
//  Copyright (c) 2015 VirrageS. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    
    var mode: Mode? {
        didSet {
            // Update the view.
            self.updateTitle()
        }
    }
    
    func updateTitle() {
        if let mode: Mode = self.mode {
            self.title = mode.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTitle()
        self.setGPS()
        
        mapView.delegate = self
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 216/255, green: 192/255, blue: 53/255, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 22)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    func setGPS() {
        let location = CLLocationCoordinate2D(
            latitude: 51.50007773,
            longitude: -0.1246402
        )
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        mapView.addAnnotations(createAnnotations(location))
    }
    
    func createAnnotations(location: CLLocationCoordinate2D) -> [MKAnnotation] {
        var annotations: [MKAnnotation] = []
        
        for var i = 0; i < 20; ++i {
            let latitude: Double = 0.0003 * Double(Int(arc4random_uniform(200)) - 100)
            let longitude: Double = 0.0003 * Double(Int(arc4random_uniform(200)) - 100)
            let newLocation = CLLocationCoordinate2D(latitude: location.latitude + latitude, longitude: location.longitude + longitude)
            
            let event = Event(name: "Event name: " + String(i), description: "Event description: " + String(i), coordinate: newLocation, creator: "Tomek")
            let annotation = MapPin(event: event)
            
            annotations.append(annotation)
        }
        
        return annotations
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEventDetail" {
            if let mapPin = sender as? MapPin {
                let event = mapPin.event as Event
                (segue.destinationViewController as! EventDetailViewController).event = event
            }
        }
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? MapPin {
            let identifier = "myPin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            
            return view
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        self.performSegueWithIdentifier("showEventDetail", sender: view.annotation)
    }
}