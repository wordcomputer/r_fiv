
//
//  MultiplayerController.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 30/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//
import UIKit
import SceneKit
import ARKit
import LocalAuthentication
import MultipeerConnectivity

extension ViewController : MCSessionDelegate {
//    
//    func startMultiplayer(){
//        let myPeerID = MCPeerID.init(displayName: "Ridwan")
//        let multiplayerSession = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .required)
//        multiplayerSession.delegate = self
//
//        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: MultipeerSession.serviceType)
//        serviceAdvertiser.delegate = self
//        serviceAdvertiser.startAdvertisingPeer()
//
//        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: MultipeerSession.serviceType)
//        serviceBrowser.delegate = self
//        serviceBrowser.startBrowsingForPeers()
//    }
//    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
}

