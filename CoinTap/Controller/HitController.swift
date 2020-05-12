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
        
        for child in spawnerNode.childNodes{
            if checkLocation(child.position, cameraLocation) {
                musicPlayer.playSound()
                vibrate()
                updateScore()
                child.removeFromParentNode()
            }
        }
    }
    
    func checkLocation(_ vector1 : SCNVector3, _ vector2 :  SCNVector3) -> Bool{
        let offsetX : Float = 1
        let offsetY : Float = 1
        let offsetZ : Float = 1
        
        if vector1.x - offsetX < vector2.x && vector2.x < vector1.x + offsetX {
            if vector1.y - offsetY < vector2.y && vector2.y < vector1.y + offsetY {
                if vector1.z - offsetZ < vector2.z && vector2.z < vector1.z + offsetZ {
                    return true
                }
            }
        }
        return false
    }
    
    func vibrate(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))  
    }
    
    func updateScore(){
        score += 1
        scoreLabel.text = String(format: "COINS %03d", score)
        if score == coinAmount {
            gameOver()
        }
    }
}
