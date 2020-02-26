
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
        closeButtonOutlet.titleLabel?.font = UIFont(name: "04b_19", size: 40)
    }
    
    func authorizeHealthKit(){
        healthKit.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
            self.healthKit.loadHealthData()
        }
    }
    
    func caloryCount(){
        print(healthKit.weight, healthKit.height)
        let weight = healthKit.weight
        let height = healthKit.height
        let caloryCoeff = [0.0006, 0.00055, 0.0005]
        if height > 1.80 {
            calories = caloryCoeff[0] * weight * Double(step)
        } else if height > 1.70 {
            calories = caloryCoeff[1] * weight * Double(step)
        }else {
            calories = caloryCoeff[2] * weight * Double(step)
        }
        
        setupStepWithCalories()
    }
    
    
    @IBAction func closeButtonDownAction(_ sender: Any) {
        let haptic = UINotificationFeedbackGenerator()
        haptic.notificationOccurred(.success)
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}