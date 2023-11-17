//
//  ResultCollectionViewCell.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 10
        backView.layer.borderWidth = 1
        backView.layer.borderColor = #colorLiteral(red: 0.1843137255, green: 0.262745098, blue: 0.3647058824, alpha: 1)
    }
    
}
