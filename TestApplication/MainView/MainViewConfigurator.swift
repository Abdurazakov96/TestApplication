//
//  MainConfigurator.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol MainViewConfiguratorProtocol: class {
    
    // MARK: - Public method
    
    func configure(with view: MainViewController)
}

class MainViewConfigurator: MainViewConfiguratorProtocol {
    
    // MARK: - Public method
    
        func configure(with viewController: MainViewController) {
            let presenter = MainViewPresenter(view: viewController)
            let interactor = MainViewInteractor()
            let router = mainViewRouter(viewController: viewController)
    
            viewController.presenter = presenter
            viewController.presenterForAddItemVC = presenter
            presenter.interactor = interactor
            presenter.router = router
        }
    
}
