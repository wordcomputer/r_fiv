
//
//  GameOverViewController.swift
//  CoinTap
//
//  Created by Ridwan Abdurrasyid on 19/09/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import HealthKitUI
import HealthKit


class GameOverViewController: UIViewController, HealthKitDelegate {
    
    @IBOutlet weak var closeButtonOutlet: UIButton!
    @IBOutlet weak var scoreLabelOutlet: UILabel!
    @IBOutlet weak var stepLabelOutlet: UILabel!
    var score = 0
    var step = 0
    var calories : Double = 0
    let healthKit = HealthKit.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        healthKit.delegate = self
        setupTitle()
        setupStep()
        authorizeHealthKit()
        // Do any additional setup after loading the view.
    }
    func setupStep(){
        stepLabelOutlet.text = "You have walked for \(String(step)) steps"
        stepLabelOutlet.font = UIFont(name: "04b_19", size: 24)
    }
    
    func setupStepWithCalories(){
        let caloriesString = String(format : "%.2f", calories)
        stepLabelOutlet.text = "You have walked for \(String(step)) steps and burned \(caloriesString) calories"
        stepLabelOutlet.font = UIFont(name: "04b_19", size: 24)
    }
    
    func setupTitle(){
        scoreLabelOutlet.text = String(score)
        scoreLabelOutlet.layer.cornerRadius = scoreLabelOutlet.frame.width / 2
        scoreLabelOutlet.layer.borderWidth = 20
        scoreLabelOutlet.layer.borderColor = #colorLiteral(red: 0.8, green: 0.2470588235, blue: 0.003921568627, alpha: 1)
        scoreLabelOutlet.font = UIFont(name: "04b_19", size: 90)