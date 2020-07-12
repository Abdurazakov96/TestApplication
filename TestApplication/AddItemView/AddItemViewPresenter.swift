//
//  AddItemPresentor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol AddItemViewOutputProtocol: class {
    func saveData(imageData: Data, title: String?, description: String?)
}

protocol AddItemViewInteractorOutputProtocol: class {
    
}

class AddItemViewPresentor: AddItemViewOutputProtocol, AddItemViewInteractorOutputProtocol  {
    
    var view: AddItemViewInputProtocol!
    var interactor: 
    required init(view: AddItemViewInputProtocol) {
        self.view = view
    }
    
    func saveData(imageData: Data, title: String?, description: String?) {
        if title != nil && description != nil {
            
        } else {
            view.activateAlert()
        }
    }
    
    
  
}
