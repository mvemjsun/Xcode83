//
//  ViewController.swift
//  xcode832
//
//  Created by Teng, Puneet on 26/05/2017.
//  Copyright © 2017. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var buttonGetCountry: UIButton!
    
    @IBOutlet weak var countryInfo: UITextField!
    
    @IBOutlet weak var messages: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Simulate a delay
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.label.text = "Country Name from ISO3 code"
        }
        
        // Simulate a delay
        let when2 = when + 1
        DispatchQueue.main.asyncAfter(deadline: when2) {
            self.textField.text = "Enter 3 letter Country Code"
        }
    }

    @IBAction func getCountryInfo(_ sender: UIButton) {
        if let cc = textField.text {
            getCountryDetails(country: cc.uppercased())
        } else {
            countryInfo.text = "Please enter a 3 letter country code."
        }
    }
    
    @IBAction func editCountryCode(_ sender: Any) {
        textField.text = ""
        messages.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCountryDetails(country: String) {
        var url : URL
        
        if let safeUrl = URL(string: "http://services.groupkt.com/country/get/iso3code/"  + country.uppercased()) {
            url = safeUrl
            
            let session = URLSession.shared
            let request = URLRequest(url: url)
            session.dataTask(with: request, completionHandler: completion).resume()
        }
    }
    
    func completion(data: Data?, response: URLResponse? , error: Error?)  {
        if let data = data,
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            let country = CountryData(json: jsonData!)
            let when = DispatchTime.now() + 1
            // Below done to simulate a delay
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.countryInfo?.text = country?.name
                self.messages.text = country?.messages.first
                
                if let safeMessages = country?.messages {
                    for message in safeMessages {
                        self.messages.text  = self.messages.text + " ," + message
                    }
                }
                
            }
            
            print(String(describing: country))
        } else {
            DispatchQueue.main.async {
                self.countryInfo.text = "Could not get data"
            }
        }
    }

}
