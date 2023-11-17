//
//  ViewControllerExtension.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var identifier : String {
        return String(describing: self)
    }
    
}

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}


extension UIViewController {
    
    
    static var identifier : String {
        return String(describing: self)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func displayLoading() -> UIActivityIndicatorView {
        
        let loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = UIColor.darkGray
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating();
        view.addSubview(loadingIndicator)
        view.alpha = 1
        view.isUserInteractionEnabled = false
        return loadingIndicator
    }
    
    func dismissLoading(_ indicator : UIActivityIndicatorView) {
        indicator.stopAnimating()
        view.alpha = 1
        
        view.isUserInteractionEnabled = true
    }
    
    func navigateToHealthConcernVC() -> HealthConcernVC {
        
        guard let viewcontroller = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: HealthConcernVC.identifier)
            as? HealthConcernVC else { return HealthConcernVC() }
        viewcontroller.modalPresentationStyle = .overFullScreen
        viewcontroller.modalTransitionStyle = .crossDissolve
        return viewcontroller
        
        
    }
    
    func navigateToDietsVC() -> DeitsVC {
        guard let viewcontroller = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: DeitsVC.identifier)
            as? DeitsVC else { return DeitsVC() }
        viewcontroller.modalPresentationStyle = .overFullScreen
        viewcontroller.modalTransitionStyle = .crossDissolve
        return viewcontroller
        
        
    }
    
    func navigateToAllergeiesVC() -> AllergeiesVC {
        
        guard let viewcontroller = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: AllergeiesVC.identifier)
            as? AllergeiesVC else { return AllergeiesVC() }
        viewcontroller.modalPresentationStyle = .overFullScreen
        viewcontroller.modalTransitionStyle = .crossDissolve
        return viewcontroller
        
    }
    
    func navigateToSetupVC() -> SetupVC {
        guard let viewcontroller = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: SetupVC.identifier)
            as? SetupVC else { return SetupVC() }
        viewcontroller.modalPresentationStyle = .overFullScreen
        viewcontroller.modalTransitionStyle = .crossDissolve
        return viewcontroller
    }
    
}



extension UITableViewCell {
    
    static var identifier: String{
        String(describing: self)
    }
}

@objc protocol ClickedDietDelegate: AnyObject {
    func clickedCheckbox (position : Int)
    func clickedInfo (position : Int)
}

