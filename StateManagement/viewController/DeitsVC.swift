//
//  DeitsVC.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import UIKit

class DeitsVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var dietList : [Diets] = []
    var resultList : [Diets] = []
    var dataManager = DataManager()
    var loading : UIActivityIndicatorView?
    
    var outputObj = OutResult()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dataManager.dietDelegate = self
        dataManager.loadDietData()
    }
    
    func setupView () {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: DietsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DietsTableViewCell.identifier)
        let noneDiet = Diets(id: 0, name: "None", tool_tip: "", isChecked: false)
        dietList.append(noneDiet)
    }
    @IBAction func clickedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedNextButton(_ sender: Any) {
        if dataManager.hasDietEnoughSelections(resultList) {
            if resultList.count == 1 && resultList[0].id == 0{
                outputObj.diets = []
            } else {
                outputObj.diets = resultList
            }
            
            let vc = self.navigateToAllergeiesVC()
            vc.outputObj = outputObj
            self.present(vc, animated: true, completion: nil)
        } else {
            showAlert(message: "Please select at least 1 diet.")
        }
        
    }
}

extension DeitsVC : DietDelegate {
    func loadingStateChanged(isLoading: Bool) {
        if isLoading {
            loading = displayLoading()
        } else {
            dismissLoading(loading ?? UIActivityIndicatorView(style: .whiteLarge))
        }
    }
    
    func DietsLoaded(_ diets: [Diets]) {
        dietList.append(contentsOf: diets)
        tableView.reloadData()
    }
    
    
}

extension DeitsVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dietList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DietsTableViewCell.identifier) as? DietsTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.setDiets(diet: dietList[indexPath.row], position: indexPath.row)
        return cell
        
    }
    
}

extension DeitsVC : ClickedDietDelegate {
    func clickedCheckbox(position: Int) {
        if dietList[position].isChecked ?? false {
            dietList[position].isChecked = false
            let filteredDiets = resultList.filter { $0.id != dietList[position].id }
            resultList = filteredDiets
        } else {
            if dietList[position].id == 0 {
                resultList.removeAll()
                dietList = dietList.map { Diets(id: $0.id, name: $0.name, tool_tip: $0.tool_tip, isChecked: false) }
            }
            resultList.append(dietList[position])
            dietList[position].isChecked = true
        }
        
        tableView.reloadData()
    }
    
    func clickedInfo(position: Int) {
        print("checked ")
    }
    
    
}
