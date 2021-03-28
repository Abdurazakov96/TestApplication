//
//  MainRouter.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol MainViewRouterProtocol {
    
    // MARK: - Public methods
    
    func openAddItemViewController()
    func openAnalizViewController()
    func openDetailViewViewController(indexPath: IndexPath)
}

class mainViewRouter: MainViewRouterProtocol {
    
    // MARK: - Init
    
    required init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Public property
    
    let viewController: MainViewController!
    
    
    // MARK: - Public methods
    
    func openDetailViewViewController(indexPath: IndexPath) {
        viewController.performSegue(withIdentifier: "DetailViewVC", sender: indexPath)
    }
    
    func openAddItemViewController() {
        viewController.performSegue(withIdentifier: "AddItemVC", sender: nil)
    }
    
    func openAnalizViewController() {
        viewController.performSegue(withIdentifier: "AnalizVC", sender: nil)
    }
    
}
