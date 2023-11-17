//
//  DietsTableViewCell.swift
//  StateManagement
//
//  Created by AyeSuNaing on 13/11/2023.
//

import UIKit

class DietsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkboxImg: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var infoImg: UIImageView!
    
    
    @IBOutlet weak var delegate : ClickedDietDelegate?
    var position : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedCheckbox))
        checkboxImg.isUserInteractionEnabled = true
        checkboxImg.addGestureRecognizer(tapGesture)
        
        let infoGesture = UITapGestureRecognizer(target: self, action: #selector(clickedinfo))
        infoImg.isUserInteractionEnabled = true
        infoImg.addGestureRecognizer(infoGesture)
    }
    
    
    func setDiets (diet : Diets, position : Int){
        if diet.isChecked == nil || !(diet.isChecked ?? false)    {
            checkboxImg.image = UIImage(named: "unchecked")
        } else {
            checkboxImg.image = UIImage(named: "checkbox")
        }
        if diet.id == 0 {
            infoImg.isHidden = true
        } else {
            
            infoImg.isHidden = false
        }
        self.position = position
        name.text = diet.name
    }
    
    @objc func clickedCheckbox(){
        delegate?.clickedCheckbox(position: position)
    }
    
    @objc func clickedinfo(){
        delegate?.clickedInfo(position: position )
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
