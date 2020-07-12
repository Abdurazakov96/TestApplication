//
//  DetailsPresentor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation


protocol DetailsViewOutputProtocol: class {
    
    // MARK: - Init
    
    init(view: DetailsViewInputProtocol)
    
    
    // MARK: - Public method
    
    func showDetails()
}

protocol DetailsViewInteractorOutputProtocol: class {
    
    // MARK: - Public method
    
    func receiveTaskDetails(task: Model)
}

class DetailsViewPresenter: DetailsViewOutputProtocol, DetailsViewInteractorOutputProtocol  {
    
    // MARK: - Public properties
    
    unowned let view: DetailsViewInputProtocol!
    var interactor: DetailsViewInteractorInputProtocol!
    
    
    // MARK: - Init
    
    required init(view: DetailsViewInputProtocol) {
        self.view = view
    }
    
    
    // MARK: - Public method
    
    func receiveTaskDetails(task: Model) {
        view.displayTaskTitle(with: task.title!)
        view.displayTaskDescription(with: task.description!)
        //        view.displayTaskImage(with: task.data)
    }
    
    func showDetails() {
        interactor.provideCourseDetails()
    }
    
}

