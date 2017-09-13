# GMDirections
Simple Google Maps Directions API for iOS

I couldn't find an easy alternative to do this. Hence, this is a simple Swift file that can be copied to your XCode/iOS/Swift project and used out of the box.

## Requirements
1. Google Maps (setup: [here](https://developers.google.com/maps/documentation/ios-sdk/start)
2. Alamofire (setup: [here](https://github.com/Alamofire/Alamofire)
3. JASON (setup: [here](https://github.com/delba/JASON)

Alamofire and JASON combinations works amazingly well in parsing JSON responses from APIs/Web requests.

## Usage
```swift
let direction = GMDirection(apiKey: "YOUR_MAPS_API_KEY", origin: sourceLoc, destination: destLoc)
direction..calculateDistance {
            success in
            if (success) {
            
            // Do your stuff
            
            }
        }
```

## What all can be calculated?
1. Travel time between source and destination

```swift
let duration = direction.getDuration()
```

2. Distance between source and destination
```swift
// distance in KM

let distance = direction.getDistance()
```

3. Polyline between source and destination
```swift
// The polyline obtained is encoded. Hence, it needs to be decoded before plotting

let path = GMSPath(fromEncodedPath: direction.getEncodedPolyline())

let polyline = GMSPolyline(path: path)
polyline.strokeWidth = 3.0
polyline.map = self.map
```

4. Get LatLng Bounds
```swift
// This can be used to focus our map in the LatLng bounds in order to show the complete path between source
// and destination that fits on the mobile screen

let bounds = direction.getLatLngBounds()
```

# License
Copyright 2017 Vishal Dubey (AutoNxt Automation Pvt. Ltd.)

Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements. See the NOTICE file distributed with this work for additional information regarding copyright ownership. The ASF licenses this file to you under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

