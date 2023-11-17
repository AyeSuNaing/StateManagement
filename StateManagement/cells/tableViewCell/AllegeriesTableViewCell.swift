//
//  AllegeriesTableViewCell.swift
//  StateManagement
//
//  Created by AyeSuNaing on 13/11/2023.
//

import UIKit

class AllegeriesTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
