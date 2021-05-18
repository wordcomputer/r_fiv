//
//  CoinSpawner.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 18/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
import GLKit

class CoinSpawner {
    let spawnerNode = SCNNode()
    let rangeRadius : Float = 15
    let rangeHeight : Float = 0.5
    let positionOffset : Float = 3
    
    func spawnCoins(coinAmount : Int) -> SCNNode{
        for i in 0...coinAmount - 1{
            let coin = Coin().getCoin()
            if i > 0 {
                randomizePosition(coin: coin)
            } else {
                coin.position = SCNVector3Make(0, 0, -2)
            }
            spawnerNode.addChildNode(coin)
     