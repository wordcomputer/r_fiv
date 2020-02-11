
//
//  FaceIDController.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 19/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import Foundation
import LocalAuthentication

extension ViewController {
    func setupLocalAuthentication(){
        // The biometryType, which affects this app's UI when state changes, is only meaningful
        //  after running canEvaluatePolicy. But make sure not to run this test from inside a
        //  policy evaluation callback (for example, don't put next line in the state's didSet
        //  method, which is triggered as a result of the state change made in the callback),
        //  because that might result in deadlock.
        
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        
        // Set the initial app state. This impacts the initial state of the UI as well.
        state = .loggedout
    }
    
    func checkFaceID(){
        if state == .loggedin {
            
            // Log out immediately.
            state = .loggedout
            
        } else {
            
            // Get a fresh context for each login. If you use the same context on multiple attempts
            //  (by commenting out the next line), then a previously successful authentication
            //  causes the next policy evaluation to succeed without testing biometry again.
            //  That's usually not what you want.
            context = LAContext()
            
//            context.localizedCancelTitle = "Enter Username/Password"
            
            // First check if we have the needed hardware support.
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                
                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                    
                    if success {
                        
                        // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async { [unowned self] in
                            self.state = .loggedin
//                            self.play()
                        }
                        
                    } else {
                        print(error?.localizedDescription ?? "Failed to authenticate")
                        
                        // Fall back to a asking for username and password.
                        // ...
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Can't evaluate policy")
                
                // Fall back to a asking for username and password.
                // ...
            }
        }
    }
}