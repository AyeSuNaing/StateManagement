//
//  SetupVC.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import UIKit

class SetupVC: UIViewController {
    
    @IBOutlet weak var dailyYesButton: RadioButton!
    @IBOutlet weak var dailyNoButton: RadioButton!
    
    
    @IBOutlet weak var smokeYesButton: RadioButton!
    @IBOutlet weak var smokeNoButton: RadioButton!
    
    
    
    @IBOutlet weak var averageFiveButton: RadioButton!
    @IBOutlet weak var averageOneButton: RadioButton!
    @IBOutlet weak var averageFivePlusButton: RadioButton!
    
    
    var outputObj = OutResult()
    var dailyButtons : [RadioButton]?
    var smokeButtons : [RadioButton]?
    var averageButtons : [RadioButton]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyButtons = [dailyYesButton, dailyNoButton]
        smokeButtons = [smokeYesButton, smokeNoButton]
        averageButtons = [averageOneButton, averageFiveButton, averageFivePlusButton]
        averageButtons?[0].isSelected = true
        smokeButtons?[1].isSelected = true
        dailyButtons?[1].isSelected = true
        outputObj.isSmoke = false
        outputObj.isDailyExposure = false
        outputObj.alcohol = "0 - 1"
    }
    
    
    @IBAction func clickedAverageButtons(_ sender: RadioButton) {
        averageButtons?.forEach({ $0.isSelected = false})
        sender.isSelected = true
        if sender == averageOneButton {
            outputObj.alcohol = "0 - 1"
            
        } else if sender == averageFiveButton {
            outputObj.alcohol = "2 - 5"
            
        } else if sender == averageFivePlusButton {
            
                outputObj.alcohol = "5+"
        }
    }
    
    
    @IBAction func clickedSmokeButtons(_ sender: RadioButton) {
        
        smokeButtons?.forEach({ $0.isSelected = false})
        sender.isSelected = true
        if sender == smokeYesButton {
            outputObj.isSmoke = true
        } else if sender == smokeNoButton {
            outputObj.isSmoke = false
        }
    }
    
    @IBAction func clickedDtailButtons(_ sender: RadioButton) {
        dailyButtons?.forEach({ $0.isSelected = false})
        sender.isSelected = true
        if sender == dailyYesButton {
            outputObj.isDailyExposure = true
        } else if sender == dailyNoButton {
            outputObj.isDailyExposure = false
        }
        
    }
    
    
    @IBAction func clickedGetVitamin(_ sender: Any) {
        
        print("Is Daily Exposure: \(outputObj.isDailyExposure ?? false)")
        print("Is Smoke: \(outputObj.isSmoke ?? false)")
        print("Alcohol: \(outputObj.alcohol ?? "")")
        print("Health Concerns: \(outputObj.healthConcerns ?? [])")
        print("Diets: \(outputObj.diets ?? [])")
        print("Allergies: \(outputObj.allergies ?? [])")
    }
    
    
}
