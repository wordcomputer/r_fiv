//
//  Coin.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 17/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class Coin : NSObject {
    var coin = SCNNode()
    var scale = 0.5
    
    
    override init() {
        super.init()
        guard let coinObject = SCNScene(named: "art.scnassets/coin.dae") else { return }
        for node in coinObject.rootNode.childNodes as [SCNNode]{