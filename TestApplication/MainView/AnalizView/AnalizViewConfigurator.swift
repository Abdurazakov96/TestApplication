//
//  AnalizViewConfigurator.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 20.10.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol AnalizViewConfiguratorProtocol: class {
    
    // MARK: - Public method
    
    func configure(with viewController: AnalizViewController)
}

class AnalizViewConfugurator: AnalizViewConfiguratorProtocol {
    
    // MARK: - Public method
    
    func configure(with viewController: AnalizViewController) {
        let presenter = AnalizViewPresenter(view: viewController)
        let interactor = AnalizViewInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
     
}
