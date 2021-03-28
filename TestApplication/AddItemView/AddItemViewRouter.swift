//
//  MainRouter.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol AddItemViewRouterProtocol {
    
    // MARK: - Public method
    
    func openMainViewTableVC()
}

class AddItemViewRouter: AddItemViewRouterProtocol {
    
    // MARK: - Init
    
    required init(viewController: AddItemViewViewController, MainViewTCprotocol: AddItemVCProtocol) {
        self.viewController = viewController
        self.MVTpresenter = MainViewTCprotocol
    }
    
    
    // MARK: - Public properties
    
    let viewController: AddItemViewViewController
    let MVTpresenter: AddItemVCProtocol
    
    
    // MARK: - Public method
    
    func openMainViewTableVC() {
        viewController.navigationController?.popViewController(animated: true)
        MVTpresenter.refreshTableView()
    }
    
}
