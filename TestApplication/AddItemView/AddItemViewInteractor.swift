//
//  AddItemInteractor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol AddItemViewInteractorInputProtocol: class {
    
    // MARK: - Public method
    
    func createModel(imageData: Data?, title: String, description: String)
}

class AddItemViewInteractor: AddItemViewInteractorInputProtocol {
    
    // MARK: - Init
    
    required init(presenter: AddItemViewInteractorOutputProtocol) {
        self.presenter = presenter
        let realm = try! Realm()
        modelList = realm.objects(Model.self)
    }
    
    // MARK: - Public property
    
    let presenter: AddItemViewInteractorOutputProtocol
    
    
    // MARK: - Private property
    
    private var modelList: Results<Model>!
    
    
    // MARK: - Public method
    
    func createModel(imageData: Data?, title: String, description: String) {
        
        let model = Model()
        model.title = title
        model.descriptionForTitle = description
        model.image = imageData
        model.statusModel = "Active"
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(model)
        }
        presenter.goRouter()
    }
    
}
