
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