//
//  MainConfigurator.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol MainViewConfiguratorProtocol: class {
    func configure(with view: MainViewTableViewController)
}

class MainViewConfigurator: MainViewConfiguratorProtocol {
    
    func configure(with viewController: MainViewTableViewController) {
        let presenter = MainViewPresentor(view: viewController)
        let interactor = MainViewInteractor(presenter: presenter)
        let router = mainViewRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    

}
