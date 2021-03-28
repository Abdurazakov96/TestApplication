//
//  DetailsInteractor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation
import RealmSwift

protocol DetailsViewInteractorInputProtocol: class {
    
    // MARK: - Public method
    
    func provideCourseDetails()
}

class DetailsViewInteractor: DetailsViewInteractorInputProtocol {
    
    // MARK: - Protocols
    
    let presenter: DetailsViewInteractorOutputProtocol
    
    
    // MARK: - Init
    
    required init(presenter: DetailsViewPresenter, indexPath: IndexPath) {
        self.presenter = presenter
        self.indexPath = indexPath
        let realm = try! Realm()
        modelList = realm.objects(Model.self)
    }
    
    
    // MARK: - Public properties
    
    var modelList: Results<Model>!
    
    
    // MARK: - Private property
    
    private let indexPath: IndexPath
    
    
    // MARK: - Public method
    
    func provideCourseDetails() {
        presenter.receiveTaskDetails(title: modelList[indexPath.row].title!, description: modelList[indexPath.row].descriptionForTitle!, image: modelList[indexPath.row].image!)
    }
    
}
