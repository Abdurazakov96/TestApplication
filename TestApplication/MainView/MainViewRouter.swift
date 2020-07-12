//
//  MainRouter.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol MainViewRouterProtocol {
    init(viewController: MainViewTableViewController)
    func openAddItemViewController()
    func openDetailViewViewController(task: Model)
}

class mainViewRouter: MainViewRouterProtocol {
    func openDetailViewViewController(task: Model) {
        viewController.performSegue(withIdentifier: "DetailViewVC", sender: task)
//        print("Переход на   работает")
    }
    
    
    func openAddItemViewController() {
        viewController.performSegue(withIdentifier: "AddItemVC", sender: nil)
        print("Переход работает")
    }
    

    
    unowned let viewController: MainViewTableViewController!
    
    required init(viewController: MainViewTableViewController) {
        self.viewController = viewController
    }
    

}
