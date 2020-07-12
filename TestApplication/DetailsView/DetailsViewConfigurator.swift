//
//  DetailsConfigurator.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol DetailsViewConfiguratorProtocol: class {
    
        // MARK: - Public method
    
    func configure(with viewController: DetailsViewViewController, task: Model)
}

class DetailsViewConfugurator: DetailsViewConfiguratorProtocol {
    
        // MARK: - Public method
    
    func configure(with viewController: DetailsViewViewController, task: Model) {
        let presenter = DetailsViewPresenter(view: viewController)
        let interactor = DetailsViewInteractor(presenter: presenter, task: task)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }

}
