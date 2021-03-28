//
//  MainPresentor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemVCProtocol: class {
    
    // MARK: - Public method
    
    func refreshTableView()
}

protocol MainViewOutputProtocol: class {
    
    // MARK: - Public properties
    
    var objectCount: Int? { get }
    var objectTitle: String? { get }
    var objectDescription: String? { get }
    var objectImage: Data? { get }
    var objectStatus: String? {get}
    var indexPathForDetailVC: IndexPath? { get }
    
    
    // MARK: - Public methods
    
    func openMainViewRouter()
    func openAnalizVC()
    func selectRow(at indexPath: IndexPath)
    func showDetail()
    func deleteModel(at indexPath: IndexPath)
    func doneModel(at indexPath: IndexPath)
    func unfulfilledModel(at indexPath: IndexPath)
}


class MainViewPresenter: MainViewOutputProtocol, AddItemVCProtocol  {

    // MARK: - Init
    
    required init(view: MainViewInputProtocol) {
        self.view = view
    }
    
    // MARK: - Protocols
    
    let view: MainViewInputProtocol!
    var router: MainViewRouterProtocol!
    var interactor: MainViewInteractorInputProtocol!
    
    // MARK: - Private property
    
    private var indexPath: IndexPath?
    
    
    // MARK: - Public Properties
    
    var objectStatus: String? {
        guard let indexPath = indexPath else { return nil }
        return interactor.getModelStatus(indexPath: indexPath)
    }
    
    var indexPathForDetailVC: IndexPath? {
        indexPath
    }
    
    var objectCount: Int? {
        interactor.getModelCount()
    }
    
    var objectTitle: String?{
        guard let indexPath = indexPath else { return nil }
        return interactor.getModelTitle(indexPath: indexPath)
    }
    
    var objectDescription: String?{
        guard let indexPath = indexPath else { return nil }
        return interactor.getModelDescription(indexPath: indexPath)
    }
    
    var objectImage: Data?{
        guard let indexPath = indexPath else { return nil }
        return interactor.getModelImage(indexPath: indexPath)
    }
    
    
    // MARK: - Public Methods
    
    func openAnalizVC() {
        router.openAnalizViewController()
    }
    
    func unfulfilledModel(at indexPath: IndexPath) {
        interactor.unfulfilledModel(indexPath: indexPath)
    }
    
    func doneModel(at indexPath: IndexPath) {
        interactor.doneModel(indexPath: indexPath)
    }
    
    func selectRow(at indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func deleteModel(at indexPath: IndexPath) {
        interactor.deleteModel(indexPath: indexPath)
    }
    
    func refreshTableView() {
        view.refreshTable()
    }
    
    func showDetail() {
        router.openDetailViewViewController(indexPath: indexPath!)
    }
    
    func openMainViewRouter() {
        router.openAddItemViewController()
    }
    
}

