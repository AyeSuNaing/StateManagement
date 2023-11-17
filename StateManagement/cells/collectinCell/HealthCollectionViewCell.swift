//
//  HealthCollectionViewCell.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import UIKit

class HealthCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    func setHealth(health : HealthConcern) {
        if health.isSelect ?? false {
            cellBackground.layer.cornerRadius = 10
            cellBackground.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.262745098, blue: 0.3647058824, alpha: 1)
            titleLbl.textColor = UIColor(hex: "#FFFFFF")
        } else {
            cellBackground.layer.cornerRadius = 10
            cellBackground.layer.borderWidth = 1
            cellBackground.layer.borderColor = #colorLiteral(red: 0.1843137255, green: 0.262745098, blue: 0.3647058824, alpha: 1)
            cellBackground.backgroundColor = UIColor.clear
            titleLbl.textColor = UIColor(hex: "#2F435D")
        }
        titleLbl.text = health.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
