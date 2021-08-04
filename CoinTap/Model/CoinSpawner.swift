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
        }
        return spawnerNode
    }
    
    func randomizePosition(coin : SCNNode){
        let x = Float.random(in: -rangeRadius...rangeRadius)
        let y = Float.random(in: -rangeHeight...rangeHeight)
        let z = Float.random(in: -rangeRadius...rangeRadius)
        coin.position = SCNVector3(x, y, z)
        if x < positionOffset && x > -positionOffset {
            if z < positionOffset && z > -positionOffset {
                randomizePosition(coin: coin)
            }
        }
        validatePosition()
    }
    
    func validatePosition(){
        if spawnerNode.childNodes.count > 2 {
            for i in 1...spawnerNode.childNodes.count - 1 {
                for j in 1...spawnerNode.childNodes.count - 1 {
                    if i != j {
                        let pos1 = SCNVector3ToGLKVector3(spawnerNode.childNodes[i].position)
                        let pos2 = SCNVector3ToGLKVector3(spawnerNode.childNodes[j].position)
                        let distance = GLKVector3Distance(pos1, pos2)
                        if distance < positionOffset {
                            print(#function, distance)
                            randomizePosition(coin: spawnerNode.chi