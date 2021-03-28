//
//  AnalizViewPresenter.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 20.10.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol AnalizViewOutputProtocol: class {
    
    // MARK: - Public method
    
    func showStatistics()
}

protocol AnalizViewInteractorOutputProtocol: class {
    
    // MARK: - Public method
    
    func getStatistics(activeGoals: Int, doneGoals: Int, undoneGoals: Int)
}

class AnalizViewPresenter: AnalizViewOutputProtocol, AnalizViewInteractorOutputProtocol  {
    
    // MARK: - Public properties
    
    var view: AnalizViewInputProtocol!
    var interactor: AnalizViewInteractorInputProtocol!
    
    
    // MARK: - Init
    
    required init(view: AnalizViewInputProtocol) {
        self.view = view
    }
    
    
    // MARK: - Public methods
    
    func getStatistics(activeGoals: Int, doneGoals: Int, undoneGoals: Int) {
        view.getTheNumberOfGoals(activeGoals: activeGoals, doneGoals: doneGoals, undoneGoals: undoneGoals)
    }
    
    func showStatistics() {
        interactor.provideStatistics()
    }
    
    
}
