//
//  FirstViewController.swift
//  CallingAPIs
//
//  Created by Waseef Akhtar on 10/10/17.
//  Copyright © 2017 Waseef Akhtar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var clockText: UILabel!
    
    var weatherString: String?
    var clockString: String?
    
    let weatherAPI = "https://api.darksky.net/forecast/17fecc7adbf7b977d04c9880dfae3a58/24.7136,46.6753"
    let clockAPI = "https://api.timezonedb.com/v2/get-time-zone?key=0WRCITELUNYD&format=json&by=zone&zone=Asia/Riyadh"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(weatherAPI).responseJSON(completionHandler: { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result.value)")                         // response serialization result
            
            let swiftyJSON = JSON(response.result.value)
            print("SwiftyJSON: \(swiftyJSON["timezone"])")
            if let currently = swiftyJSON["currently"].dictionaryObject {
                print(currently["temperature"])
                self.weatherString = "It feels like \(String(describing: currently["temperature"]!)) in Riyadh currently."
            }
        })
        
        Alamofire.request(clockAPI).responseJSON(completionHandler: { response in
            
            let swiftyJSON = JSON(response.result.value)
            print("SwiftyJSON: \(swiftyJSON)")
            self.clockString = "The local date & time currently is \(swiftyJSON["formatted"].stringValue)."
        })
        
    }
    
    @IBAction func showWeather(_ sender: Any) {
        DispatchQueue.main.async {
            self.labelText.text = self.weatherString
        }
    }
    
    @IBAction func showClock(_ sender: Any) {
        DispatchQueue.main.async {
            self.clockText.text = self.clockString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

