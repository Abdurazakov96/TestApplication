//
//  MainViewInteractor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 04.10.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation
import RealmSwift

protocol MainViewInteractorInputProtocol {
    
    // MARK: - Public method
    
    func getModelCount() -> Int?
    func getModelTitle(indexPath: IndexPath) -> String?
    func getModelDescription(indexPath: IndexPath) -> String?
    func getModelImage(indexPath: IndexPath) -> Data?
    func getModelStatus(indexPath: IndexPath) -> String?
    func deleteModel(indexPath: IndexPath)
    func doneModel(indexPath: IndexPath)
    func unfulfilledModel(indexPath: IndexPath)
}

class MainViewInteractor: MainViewInteractorInputProtocol {
    
    // MARK: - Init
    
    required init() {
        
        let realm = try! Realm()
        modelList = realm.objects(Model.self)
        
    }
    
    
    // MARK: - Private property
    
    private var modelList: Results<Model>!
    
    
    // MARK: - Public Methods
    
    func unfulfilledModel(indexPath: IndexPath) {
        let realm = try! Realm()
        
        let model =  realm.objects(Model.self)[indexPath.row]
        
        try! realm.write {
            model.statusModel = "Unfulfilled"
        }
        
    }
    
    func doneModel(indexPath: IndexPath) {
        let realm = try! Realm()
        
        let model =  realm.objects(Model.self)[indexPath.row]
        
        try! realm.write {
            model.statusModel = "Done"
        }
        
    }
    
    func getModelStatus(indexPath: IndexPath) -> String? {
        modelList[indexPath.row].statusModel
    }
    
    func deleteModel(indexPath: IndexPath) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(self.modelList[indexPath.row])
        }
        
    }
    
    func getModelImage(indexPath: IndexPath) -> Data? {
        modelList[indexPath.row].image
    }
    
    func getModelDescription(indexPath: IndexPath) -> String? {
        return modelList[indexPath.row].descriptionForTitle
    }
    
    func getModelCount() -> Int? {
        return modelList.count
    }
    
    func getModelTitle(indexPath: IndexPath) -> String? {
        return modelList[indexPath.row].title
    }
    
}
