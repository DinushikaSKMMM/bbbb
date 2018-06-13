//
//  EventListViewController.swift
//  LogIn
//
//  Created by Insharp on 3/23/17.
//  Copyright © 2017 Insharp. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces

class EventListViewController: UIViewController,GMSAutocompleteViewControllerDelegate {
    @IBOutlet weak var googleMapView: GMSMapView!
        override func viewDidLoad() {
        super.viewDidLoad()
    }
    public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        googleMapView.clear()
        print("Place name: \(place.name)")
        let locationName = place.name
        let locationCordinate = place.coordinate.latitude
        let locationLongertude = place.coordinate.longitude
        print("Place address: \(place.formattedAddress)")
        let address = place.formattedAddress!
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
        let camera = GMSCameraPosition.camera(withLatitude: locationCordinate, longitude: locationLongertude, zoom: 6)
        googleMapView.animate(to: camera)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locationCordinate, longitude: locationLongertude)
        marker.map = googleMapView
       }

    @IBAction func searchLocation(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    func mapViewLocation(){
    }
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
