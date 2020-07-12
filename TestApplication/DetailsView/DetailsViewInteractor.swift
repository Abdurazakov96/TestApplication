//
//  DetailsInteractor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol DetailsViewInteractorInputProtocol: class {
    
    // MARK: - Init
    
    init(presenter: DetailsViewPresenter, task: Model)
    
    
    // MARK: - Public method
    
    func provideCourseDetails()
}

class DetailsViewInteractor: DetailsViewInteractorInputProtocol {
    
    // MARK: - Public property
    
    unowned let presenter: DetailsViewInteractorOutputProtocol
    
    
    // MARK: - Private property
    
    private let task: Model
    
    
    // MARK: - Init
    
    required init(presenter: DetailsViewPresenter, task: Model) {
        self.presenter = presenter
        self.task = task
    }
    
    
    // MARK: - Public method
    
    func provideCourseDetails() {
        presenter.receiveTaskDetails(task: task)
    }
    
}
