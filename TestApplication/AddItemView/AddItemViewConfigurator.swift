//
//  AddItemConfihurator.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol AddItemViewConfiguratorProtocol: class {
    
            // MARK: - Public method
    
    func configure(with view: AddItemViewViewController)
}

class AddItemViewConfigurator: AddItemViewConfiguratorProtocol {
    
            // MARK: - Public method
    
    func configure(with viewController: AddItemViewViewController) {
        let presenter = AddItemViewPresenter(view: viewController)
        let interactor = AddItemViewInteractor(presenter: presenter)
        let router = AddItemViewRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
