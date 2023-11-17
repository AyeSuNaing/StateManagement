//
//  ViewController.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
    }
    @IBAction func clickedGetStarted(_ sender: Any) {
        let vc = self.navigateToHealthConcernVC()
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

