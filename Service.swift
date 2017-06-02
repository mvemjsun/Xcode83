//
//  Service.swift
//  xcode832
//
//  Created by Teng, Puneet on 31/05/2017.
//  Copyright © 2017 . All rights reserved.
//

import Foundation

struct CountryData {
    var messages : Set<String> = []
    var name: String?
    var alpha2Code: String?
    var alpha3Code: String?
}

extension CountryData {
    
    init?(json: [String: Any]) {
        if let countryDataJson = json["RestResponse"] as? [String: Any] {
            let countryData = countryDataJson["result"] as? [String: Any]
            name = countryData?["name"] as? String
            alpha2Code = countryData?["alpha2_code"] as? String
            alpha3Code = countryData?["alpha3_code"] as? String
            for messageData in (countryDataJson["messages"] as? [String])! {
                messages.insert(messageData)
            }
        }
    }
}
