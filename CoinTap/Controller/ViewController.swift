
//
//  ViewController.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 17/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import LocalAuthentication

class ViewController: UIViewController, ARSCNViewDelegate {

    //Game Balance
    let timeAmount = 180
    let coinAmount = 40
    //
    
    @IBOutlet weak var commandLabelOutlet: UILabel!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    let musicPlayer = MusicPlayer.instance
    let pedometer = Pedometer()
    var spawnerNode = SCNNode()
    var audioPlayer = AVAudioPlayer()
    var score : Int = 0
    var seconds = 10
    let labelSize : CGFloat = 25
    var timer = Timer()
    var isTimerRunning = false
    
    var context = LAContext()
    
    /// The available states of being logged in or not.
    enum AuthenticationState {
        case loggedin, loggedout
    }
    
    /// The current authentication state.
    var state = AuthenticationState.loggedout
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocalAuthentication()
        setupScore()
        setupCommandText()
        setupTimer()
        setupPlayButton()
        setupScene()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func setupPlayButton(){
        playButtonOutlet.isHidden = false
        playButtonOutlet.layer.cornerRadius = playButtonOutlet.frame.width/2
        playButtonOutlet.layer.borderWidth = 12
        playButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8, green: 0.2470588235, blue: 0.003921568627, alpha: 1)
        playButtonOutlet.titleLabel?.font = UIFont(name: "04b_19", size: 90)
        playButtonOutlet.titleLabel?.numberOfLines = 0
        playButtonOutlet.titleLabel?.textAlignment = .center
        playButtonOutlet.transform = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.playButtonOutlet.transform = CGAffineTransform(translationX: 0, y: 10)
        }, completion: { _ in
            
        })
    }
    
    func setupCommandText(){
        commandLabelOutlet.isHidden = false
        commandLabelOutlet.font = UIFont(name: "04b_19", size: 30)