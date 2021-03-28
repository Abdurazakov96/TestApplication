//
//  MainInteractor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol MainViewInteractorInputProtocol: class {
    
    // MARK: - Public method
    
    func saveModel()
}

class MainViewInteractor: MainViewInteractorInputProtocol {
    
    // MARK: - Public property
    
    unowned let presenter: MainViewInteractorOutputProtocol
    
    
    // MARK: - Init
    
    required init(presenter: MainViewInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    
    // MARK: - Public method
    
    func saveModel() {
        print("dsad")
    }
    
}


