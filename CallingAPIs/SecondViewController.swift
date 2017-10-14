//
//  SecondViewController.swift
//  CallingAPIs
//
//  Created by Waseef Akhtar on 10/10/17.
//  Copyright © 2017 Waseef Akhtar. All rights reserved.
//

import UIKit
import GoogleMaps

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 24.7136, longitude: 46.6753, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 24.7136, longitude: 46.6753)
        marker.title = "Riyadh"
        marker.snippet = "Saudi Arabia"
        marker.map = mapView
    }


}

