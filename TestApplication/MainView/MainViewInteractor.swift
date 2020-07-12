//
//  MainInteractor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol MainViewInteractorInputProtocol: class {
    func saveModel()
}

class MainViewInteractor: MainViewInteractorInputProtocol {
    
        unowned let presenter: MainViewInteractorOutputProtocol
    
        required init(presenter: MainViewInteractorOutputProtocol) {
            self.presenter = presenter
        }
    
    func saveModel() {
        print("dsad")
    }
    
    
}


