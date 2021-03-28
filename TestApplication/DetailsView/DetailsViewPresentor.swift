//
//  DetailsPresentor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation


protocol DetailsViewOutputProtocol: class {
    
    // MARK: - Public method
    
    func showDetails()
}

protocol DetailsViewInteractorOutputProtocol: class {
    
    // MARK: - Public method
    
    func receiveTaskDetails(title: String, description: String, image: Data)
}

class DetailsViewPresenter: DetailsViewOutputProtocol, DetailsViewInteractorOutputProtocol  {
    
    // MARK: - Init
    
    required init(view: DetailsViewInputProtocol) {
        self.view = view
    }
    
    
    // MARK: - protocols
    
    let view: DetailsViewInputProtocol!
    var interactor: DetailsViewInteractorInputProtocol!
    
    
    // MARK: - Public methods
    
    func receiveTaskDetails(title: String, description: String, image: Data) {
        view.displayObjectTitle(with: title)
        view.displayObjectDescription(with: description)
        view.displayObjectImage(with: image)
    }
    
    func showDetails() {
        interactor.provideCourseDetails()
        
    }
    
}

