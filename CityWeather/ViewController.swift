//
//  ViewController.swift
//  CityWeather
//
//  Created by junseok on 2018-04-07.
//  Copyright © 2018 junseok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityName: UITextField!
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var weatherResult: UILabel!
    
    //For JSON Data
    var datalist = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func okButton(_ sender: UIButton) {
        //URL openweathermamp
        let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName.text!)&APPID=17857324004c9ba37c60d380183ae90d")
        
        do {
            //JSON Parsing from baseURL
            //Data - provides data objects, or object-oriented wrappers for byte buffers.
            datalist = try JSONSerialization.jsonObject(with: Data(contentsOf: baseURL!), options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        } catch {
            print("Error loading Data")
        }
        
        //NSDictionary
        print("datalist: \(self.datalist)")
        
        //NSArray
        let weatherData = datalist["weather"] as! NSArray
        
        //NSArray to String
        let descriptionData = String(describing: weatherData.value(forKey: "main"))
        var tempStr = descriptionData.replacingOccurrences(of: "\"", with: "")
        tempStr = tempStr.replacingOccurrences(of: "(", with: "")
        tempStr = tempStr.replacingOccurrences(of: ")", with: "")
        tempStr = tempStr.trimmingCharacters(in: .whitespacesAndNewlines)
        var tempStr1 = tempStr.split(separator: ",")
        
        print("description: \(descriptionData)")
        
        print("type of datalist: \(type(of: datalist))")
        print("type of weatherData: \(type(of: weatherData))")
        print("type of baseURL: \(type(of: baseURL!))")
        print("type of tempStr: \(type(of: tempStr))")
        print("type of tempStr1: \(type(of: tempStr1))")
        print("tempStr1: \(tempStr1[0])")
        
        //Showing img based on weather
        if tempStr1[0] == "Clouds"{
            weatherImg.image = UIImage(named: "cloud.png")
        }
        if tempStr1[0] == "Clear"{
            weatherImg.image = UIImage(named: "clear.jpg")
        }
        if tempStr1[0] == "Haze"{
            weatherImg.image = UIImage(named: "haze.png")
        }
        if tempStr1[0] == "Snow"{
            weatherImg.image = UIImage(named: "snow.png")
        }
        if tempStr1[0] == "Rain" || tempStr1[0] == "Mist" || tempStr1[0] == "Drizzle"{
            weatherImg.image = UIImage(named: "rain.jpg")
        }
        
       weatherResult.text = String(tempStr1[0])
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

