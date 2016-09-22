//
//  ViewController.swift
//  PKExample
//
//  Created by Scott Newman on 5/11/16.
//  Copyright © 2016 Radius Networks. All rights reserved.
//

import UIKit
import ProximityKit

class ViewController: UIViewController, RPKManagerDelegate {

  var proximityKitManager: RPKManager?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()

    if let path = NSBundle.mainBundle().pathForResource("ProximityKit", ofType:"plist") {
      if let dict = NSDictionary(contentsOfFile:path) {
        self.proximityKitManager = RPKManager(delegate:self, andConfig:dict as [NSObject : AnyObject])
      }
    }
    else {
      let reason = "The ProximityKit.plist configuration file is missing."
      NSException(name:"Missing Configuration File", reason:reason, userInfo:nil).raise()
    }
    
    if let proximityKitManager = self.proximityKitManager {
      proximityKitManager.start()
    }
    
  }

  // MARK: Proximity Kit Delegate Methods
  
  func proximityKitDidSync(manager : RPKManager) {
    print("Proximity Kit did sync")
  }
  
  func proximityKit(manager: RPKManager!, didDetermineState state: RPKRegionState, forRegion region: RPKRegion!) {
    
    var stateDescription: String
    
    switch (state) {
    case .Inside:
      stateDescription = "Inside"
      
    case .Outside:
      stateDescription = "Outside"
      
    case .Unknown:
      stateDescription = "Unknown"
    }
    print("State Changed: \(stateDescription) Region \(region.name) (\(region.identifier))")
  }
  
  func proximityKit(manager : RPKManager, didEnter region:RPKRegion) {
    print("Entered Region \(region.name), \(region.identifier)");
  }
  
  func proximityKit(manager : RPKManager, didExit region:RPKRegion) {
    print("Exited Region \(region.name), \(region.identifier)");
  }
  
  func proximityKit(manager: RPKManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: RPKBeaconRegion!) {
    for beacon in beacons as! [RPKBeacon] {
      print("Major: \(beacon.major), Minor: \(beacon.minor)")
    }
  }
}

