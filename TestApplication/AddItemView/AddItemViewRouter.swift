//
//  MainRouter.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol AddItemViewRouterProtocol {
    
    // MARK: - Init
    
    init(viewController: AddItemViewViewController)
    
    // MARK: - Public method
    
    func openMainViewTableVC(model: Model)
}

class AddItemViewRouter: AddItemViewRouterProtocol {
    
    // MARK: - Public property
    
    unowned let viewController: AddItemViewViewController
    
    
    // MARK: - Init
    
    required init(viewController: AddItemViewViewController) {
        self.viewController = viewController
    }
    
    
    // MARK: - Public method
    
    func openMainViewTableVC(model: Model) {
        viewController.performSegue(withIdentifier: "", sender: model)
    }
    
    func openAddItemViewController() {
        viewController.performSegue(withIdentifier: "AddItemVC", sender: nil)
    }
    
}
