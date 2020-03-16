//
//  HitController.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 18/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
import AVFoundation

extension ViewController : ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        checkCoin()
    }
    
    func checkCoin(){
        let cameraTransform = sceneView.pointOfView!.transform
        let cameraLocation = SCNVector3Make(cameraTransform.m41, cameraTransform.m42, cameraTransform.m43)
