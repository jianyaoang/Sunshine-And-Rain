//
//  WeatherDetailsVC.swift
//  SunshineAndRain
//
//  Created by Jian Yao Ang on 10/28/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailsVC: UIViewController {
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var temperatureSummary: UILabel!
    
    var weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extractingForecastWeatherInfo()
    }
    
    func extractingForecastWeatherInfo()
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            
            let forecastURL = NSURL(string: "https://api.forecast.io/forecast/3d86cce802204ef2649df08af007d6ee/37.8267,-122.423")
            
            let urlSession = NSURLSession.sharedSession()
            
            let urlRequest = NSURLRequest(URL: forecastURL!)
            
            var downloadTask = urlSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
                
                if error == nil
                {
                    let forecastData = NSData(contentsOfURL: location)
                    
                    let forecastWeatherDictionary: AnyObject? = NSJSONSerialization.JSONObjectWithData(forecastData!, options: nil, error: nil)
                
                    self.weather.temperature! = (forecastWeatherDictionary as AnyObject?)?.valueForKeyPath("currently.temperature") as Int
                    self.weather.summary! = (forecastWeatherDictionary as AnyObject?)?.valueForKeyPath("currently.summary") as String
                }
                else
                {
                    println("there is an error %@", error)
                }
        
                dispatch_async(dispatch_get_main_queue())
                {
                    self.assigningValuesToLabel()
                }
            })
            downloadTask.resume()
        })
    }
    
    func assigningValuesToLabel(){
        self.temperatureLabel.text = String(format: "%i F",self.weather.temperature!)
        self.temperatureSummary.text = self.weather.summary
    }
    
}
