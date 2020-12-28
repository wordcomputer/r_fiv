
//
//  Camera.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 17/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

struct myCameraCoordinates {
    var x = Float()
    var y = Float()
    var z = Float()
}

class Camera {
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let camera = sceneView.session.currentFrame?.camera
        let cameraTransform = camera!.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform)
    
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
    
        return cc
    }
}
