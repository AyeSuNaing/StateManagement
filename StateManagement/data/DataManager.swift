//
//  DataManager.swift
//  StateManagement
//
//  Created by AyeSuNaing on 13/11/2023.
//

import Foundation


protocol HealthConcenDelegate: AnyObject {
    func loadingStateChanged(isLoading: Bool)
    func healthConcernsLoaded(_ healthConcerns: [HealthConcern])
}

protocol DietDelegate: AnyObject {
    func loadingStateChanged(isLoading: Bool)
    func DietsLoaded(_ diets: [Diets])
}

protocol AllergyDelegate: AnyObject {
    func loadingStateChanged(isLoading: Bool)
    func AllergyLoaded(_ allergies: [Allergies])
}

class DataManager {
    
    weak var delegate: HealthConcenDelegate?
    weak var dietDelegate: DietDelegate?
    
    weak var allergyDelegate: AllergyDelegate?
    
    private var isLoading = false
    private var isdietLoading = false
    private var isAlligeyLoading = false
    
    
    func loadData() {
        guard !isLoading else { return }
        
        setLoadingState(true)
        do {
            let healthConcerns = try self.loadHealthConcerns()
            self.delegate?.healthConcernsLoaded(healthConcerns )
        } catch {
            print("Error loading health concerns: \(error)")
        }
        
        self.setLoadingState(false)
    }
    
    private func setLoadingState(_ isLoading: Bool) {
        self.isLoading = isLoading
        delegate?.loadingStateChanged(isLoading: isLoading)
    }
    
    private func loadHealthConcerns() throws -> [HealthConcern] {
        
        guard let path = Bundle.main.path(forResource: "healthConcerns", ofType: "json") else {
            print("Error: JSON file not found.")
            return []
        }
        
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let healths = try JSONDecoder().decode(HealthConcernList.self, from: data)
            return healths.data
        } catch {
            print("Error reading/parsing JSON file: \(error.localizedDescription)")
            throw error
        }
    }
    
    
    func hasEnoughSelections(_ selections: [HealthConcern]) -> Bool {
        return selections.count > 5
    }
    
    func loadDietData() {
        guard !isdietLoading else { return }
        setDietLoadingState(true)
        do {
            let diets = try self.loadDietsConcerns()
            self.dietDelegate?.DietsLoaded(diets)
        } catch {
            print("Error loading Diets: \(error)")
        }
        
        self.setDietLoadingState(false)
    }
    
    private func setDietLoadingState(_ isLoading: Bool) {
        self.isdietLoading = isLoading
        dietDelegate?.loadingStateChanged(isLoading: isdietLoading)
    }
    
    private func loadDietsConcerns() throws -> [Diets] {
        
        guard let path = Bundle.main.path(forResource: "diets", ofType: "json") else {
            print("Error: JSON file not found.")
            return []
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let diets = try JSONDecoder().decode(DietsList.self, from: data)
            return diets.data
        } catch {
            print("Error reading/parsing JSON file: \(error.localizedDescription)")
            throw error
        }
    }
    
    func hasDietEnoughSelections(_ selections: [Diets]) -> Bool {
        return selections.count > 0
    }
    
    
    func loadAllergyData() {
        guard !isdietLoading else { return }
        
        setAllergyLoadingState(true)
        do {
            let allergies = try self.loadAllergyConcerns()
            self.allergyDelegate?.AllergyLoaded(allergies)
        } catch {
            print("Error loading Diets: \(error)")
        }
        self.setAllergyLoadingState(false)
    }
    
    private func setAllergyLoadingState(_ isLoading: Bool) {
        self.isAlligeyLoading = isLoading
        allergyDelegate?.loadingStateChanged(isLoading: isAlligeyLoading)
    }
    
    private func loadAllergyConcerns() throws -> [Allergies] {
        
        guard let path = Bundle.main.path(forResource: "allergies", ofType: "json") else {
            print("Error: JSON file not found.")
            return []
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let allergies = try JSONDecoder().decode(AllergiesList.self, from: data)
            return allergies.data
        } catch {
            print("Error reading/parsing JSON file: \(error.localizedDescription)")
            throw error
        }
    }
    
}
