//
//  AddItemInteractor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol AddItemViewInteractorInputProtocol: class {
    
    // MARK: - Public method
    
    func createModel(imageData: Data!, title: String, description: String)
}

class AddItemViewInteractor: AddItemViewInteractorInputProtocol {
    
    // MARK: - Public property
    
    unowned let presenter: AddItemViewInteractorOutputProtocol
    
    
    // MARK: - Init
    
    required init(presenter: AddItemViewInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    
    // MARK: - Public method
    
    func createModel(imageData: Data!, title: String, description: String) {
        let model = Model(title: title, description: description, data: imageData!)
        presenter.saveModel(model: model)
    }
    
}
