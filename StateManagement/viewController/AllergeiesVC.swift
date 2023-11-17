//
//  AllergeiesVC.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import UIKit

class AllergeiesVC: UIViewController {
    
    @IBOutlet weak var autoCompleteTableView: UITableView!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var allergeiesList : [Allergies] = []
    var filteredAllergies : [Allergies] = []
    var resultList : [Allergies] = []
    var outputObj = OutResult()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readAllergeiesJSON()
        
        autoCompleteTableView.register(UINib(nibName: AllegeriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AllegeriesTableViewCell.identifier)
        
        resultTableView.register(UINib(nibName: AllegeriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AllegeriesTableViewCell.identifier)
        
        textField.delegate = self
        autoCompleteTableView.delegate = self
        autoCompleteTableView.dataSource = self
        
        textField.autocorrectionType = .no
        autoCompleteTableView.isHidden = true
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        
    }
    
    func readAllergeiesJSON() {
        if let path = Bundle.main.path(forResource: "allergies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let allegery = try JSONDecoder().decode(AllergiesList.self, from: data)
                allergeiesList = allegery.data
            } catch {
                print("Error reading/parsing JSON file: \(error.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func clickedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedNextButton(_ sender: Any) {
        outputObj.allergies = resultList
        let vc = self.navigateToSetupVC()
        vc.outputObj = outputObj
        self.present(vc, animated: true, completion: nil)
    }
    
}


extension AllergeiesVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        filterAllergies(for: currentText)
        return true
    }
    
    func filterAllergies(for prefix: String)  {
        filteredAllergies = allergeiesList.filter { $0.name.lowercased().contains(prefix.lowercased()) }
        autoCompleteTableView.reloadData()
        autoCompleteTableView.isHidden = filteredAllergies.isEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ((textField.text?.isEmpty) != nil) {
            let check = resultList.contains { $0.name.lowercased() == textField.text?.lowercased() }
            
            if check {
                resultList.append( allergeiesList.first { $0.name.lowercased() == textField.text?.lowercased() }!)
            } else {
                let allergy = Allergies(id: 0, name: textField.text!)
                resultList.append(allergy)
            }
            resultTableView.reloadData()
        }
        textField.text = ""
        textField.resignFirstResponder()
        
        return true
    }
    
}

extension AllergeiesVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == autoCompleteTableView {
            return filteredAllergies.count
        } else if tableView == resultTableView {
            return resultList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == autoCompleteTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllegeriesTableViewCell.identifier) as? AllegeriesTableViewCell else { return UITableViewCell() }
            cell.textLbl.textColor = UIColor.gray
            cell.bgView.backgroundColor = UIColor.clear
            cell.textLbl?.text = filteredAllergies[indexPath.row].name
            
            return cell
        } else if tableView == resultTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllegeriesTableViewCell.identifier) as? AllegeriesTableViewCell else { return UITableViewCell() }
            cell.textLbl?.text = resultList[indexPath.row].name
            
            return cell
        }
        return UITableViewCell()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didselectedrow    \(tableView)")
        if tableView == autoCompleteTableView {
            let selectedSuggestion = filteredAllergies[indexPath.row].name
            textField.text = selectedSuggestion
            tableView.isHidden = true
        } else if tableView == resultTableView {
            //
        }
        
    }
    
}

