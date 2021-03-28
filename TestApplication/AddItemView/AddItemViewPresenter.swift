//
//  AddItemPresentor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewOutputProtocol: class {
    
    // MARK: - Public method
    
    func saveData(imageData: Data?, title: String?, description: String?)
}

protocol AddItemViewInteractorOutputProtocol: class {
    
    // MARK: - Public method
    
    func goRouter()
}

class AddItemViewPresenter: AddItemViewOutputProtocol, AddItemViewInteractorOutputProtocol  {
    
    // MARK: - Init
    
    required init(view: AddItemViewInputProtocol) {
        self.view = view
    }
    
    
    // MARK: - Protocols
    
    let view: AddItemViewInputProtocol
    var interactor: AddItemViewInteractorInputProtocol!
    var router: AddItemViewRouterProtocol!
    
    
    // MARK: - Public methods
    
    func goRouter() {
        router.openMainViewTableVC()
    }
    
    func saveData(imageData: Data?, title: String?, description: String?) {
        if title != "" && description != "" {
            interactor.createModel(imageData: imageData, title: title!, description: description!)
        } else {
            view.showAlert()
        }
        
    }
    
}
