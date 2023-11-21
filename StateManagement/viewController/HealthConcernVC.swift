//
//  HealthConcernVC.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import UIKit

class HealthConcernVC: UIViewController {
    
    @IBOutlet weak var healthCollectionView: UICollectionView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    var healthList : [HealthConcern] = []
    var resultList : [HealthConcern] = []
    
    var outputObj = OutResult()
    var dataManager = DataManager()
    var loading : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        dataManager.delegate = self
        dataManager.loadData()
    }
    
    func setupCollectionView() {
        healthCollectionView.register(UINib(nibName: HealthCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HealthCollectionViewCell.identifier)
        resultCollectionView.register(UINib(nibName: ResultCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        healthCollectionView.delegate = self
        healthCollectionView.dataSource = self
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.dragInteractionEnabled = true
        resultCollectionView.isUserInteractionEnabled = true
        resultCollectionView.dragDelegate = self
        resultCollectionView.dropDelegate = self
    }
    
    @IBAction func clickedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clickedNextButton(_ sender: Any) {
        if dataManager.hasEnoughSelections(resultList) {
            outputObj.healthConcerns = resultList
            let vc = navigateToDietsVC()
            vc.outputObj = outputObj
            present(vc, animated: true, completion: nil)
        } else {
            showAlert(message: "Please select at least 6 health concerns.")
        }
        
    }
    
    
    
}

extension HealthConcernVC: HealthConcenDelegate {
    
    func loadingStateChanged(isLoading: Bool) {
        if isLoading {
            loading = displayLoading()
        } else {
            dismissLoading(loading ?? UIActivityIndicatorView(style: .whiteLarge))
        }
    }
    
    func healthConcernsLoaded(_ healthConcerns: [HealthConcern]) {
        healthList = healthConcerns
        healthCollectionView.reloadData()
    }
}

extension HealthConcernVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == healthCollectionView {
            return healthList.count
        } else if collectionView == resultCollectionView {
            return resultList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == healthCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HealthCollectionViewCell.identifier, for: indexPath) as! HealthCollectionViewCell
            cell.setHealth(health: healthList[indexPath.row])
            return cell
        } else if collectionView == resultCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as! ResultCollectionViewCell
            cell.nameLbl.text = resultList[indexPath.row].name
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == healthCollectionView {
            return CGSize(width: healthList[indexPath.item].name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width, height: 40)
        } else if collectionView == resultCollectionView {
            return CGSize(width: collectionView.bounds.width, height: 30)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == healthCollectionView {
            if healthList[indexPath.row].isSelect ?? false {
                resultList = resultList.filter {$0.id != healthList[indexPath.row].id }
                healthList[indexPath.row].isSelect = false
            } else {
                healthList[indexPath.row].isSelect = true
                resultList.append(healthList[indexPath.row])
            }
            
            resultCollectionView.reloadData()
            
            let  cell : HealthCollectionViewCell = collectionView.cellForItem(at: indexPath) as! HealthCollectionViewCell
            cell.setHealth(health: healthList[indexPath.row])
            
        } else if collectionView == resultCollectionView {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = resultList.remove(at: sourceIndexPath.item)
        resultList.insert(movedItem, at: destinationIndexPath.item)
    }
    
}

extension HealthConcernVC :  UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let healthConcern = resultList[indexPath.item]
        let itemProvider = NSItemProvider(object: healthConcern.name as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
           print("Comming to dropSessionDidUpdate")
           return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
       }
       

       func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
           let destinationIndexPath: IndexPath

           if let indexPath = coordinator.destinationIndexPath {
               destinationIndexPath = indexPath
           } else {
               // If the drop is between cells, calculate the destination index path
               let section = collectionView.numberOfSections - 1
               let row = collectionView.numberOfItems(inSection: section)
               destinationIndexPath = IndexPath(row: row, section: section)
           }

           // Process the dropped items
           coordinator.items.forEach { item in
               guard let sourceIndexPath = item.sourceIndexPath else { return }
               let movedItem = resultList.remove(at: sourceIndexPath.item)
               resultList.insert(movedItem, at: destinationIndexPath.item)

               collectionView.performBatchUpdates({
                   collectionView.deleteItems(at: [sourceIndexPath])
                   collectionView.insertItems(at: [destinationIndexPath])
               })
               coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
           }
       }
       
       
       
    
    
    
    
}
