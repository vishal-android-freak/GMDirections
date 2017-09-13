//
//  GMDirections.swift
//  TrackRT
//
//  Created by Vishal Dubey on 11/07/17.
//  Copyright © 2017 AutoNxt Automation Pvt. Ltd. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import JASON

class GMDirections {
    
    var apiKey: String!
    var origin: CLLocationCoordinate2D!
    var destination: CLLocationCoordinate2D!
    var duration: String?
    var distance: String?
    var encodedPolyline: String?
    var latLngBounds: [String:CLLocationCoordinate2D]?
    
    init (apiKey: String, origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        self.apiKey = apiKey
        self.origin = origin
        self.destination = destination
    }
    
    func calculateDistance(completion: @escaping (Bool) -> Void) {
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json", method: .get,parameters: ["origin":"\(origin.latitude),\(origin.longitude)", "destination":"\(destination.latitude),\(destination.longitude)", "key":apiKey]).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    let response = JSON(json)
                    let routes = response["routes"][0]
                    self.latLngBounds = ["northeast":CLLocationCoordinate2D(latitude: routes["bounds"]["northeast"]["lat"].doubleValue, longitude: routes["bounds"]["northeast"]["lng"].doubleValue), "southwest":CLLocationCoordinate2D(latitude: routes["bounds"]["southwest"]["lat"].doubleValue, longitude: routes["bounds"]["southwest"]["lng"].doubleValue)]
                    self.duration = routes["legs"][0]["distance"]["text"].stringValue
                    self.distance = routes["legs"][0]["duration"]["text"].stringValue
                    self.encodedPolyline = routes["overview_polyline"]["points"].stringValue
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func getDuration() -> String {
        return duration!
    }
    
    func getDistance() -> String {
        return distance!
    }
    
    func getEncodedPolyline() -> String {
        return encodedPolyline!
    }
    
    func getLatLngBounds() -> [String: CLLocationCoordinate2D] {
        return latLngBounds!
    }
}
