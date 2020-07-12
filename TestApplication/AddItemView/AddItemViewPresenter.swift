//
//  AddItemPresentor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol AddItemViewOutputProtocol: class {
    
    // MARK: - Public method
    
    func saveData(imageData: Data, title: String?, description: String?)
}

protocol AddItemViewInteractorOutputProtocol: class {
    
    // MARK: - Public method
    
    func saveModel(model: Model)
}

class AddItemViewPresenter: AddItemViewOutputProtocol, AddItemViewInteractorOutputProtocol  {
    
    // MARK: - Public property
    
    unowned let view: AddItemViewInputProtocol
    var interactor: AddItemViewInteractorInputProtocol!
    var router: AddItemViewRouterProtocol!
    
    
    // MARK: - Init
    
    required init(view: AddItemViewInputProtocol) {
        self.view = view
    }
    
    
    // MARK: - Public methods
    
    func saveModel(model: Model) {
        router.openMainViewTableVC(model: model)
    }
    
    func saveData(imageData: Data, title: String?, description: String?) {
        if title != "" && description != "" {
            interactor.createModel(imageData: imageData, title: title!, description: description!)
        } else {
            view.activateAlert()
        }
        
    }
    
}
