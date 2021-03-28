//
//  AnalizViewInteractor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 20.10.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation
import RealmSwift

protocol AnalizViewInteractorInputProtocol: class {
    
    // MARK: - Public method
    
    func provideStatistics()
}

class AnalizViewInteractor: AnalizViewInteractorInputProtocol {
    
    // MARK: - Public properties
    
    let presenter: AnalizViewInteractorOutputProtocol
    var activeGoals = 0
    var doneGoals = 0
    var undoneGoals = 0
    var modelList: Results<Model>!
    
    
    // MARK: - Init
    
    required init(presenter: AnalizViewPresenter) {
        self.presenter = presenter
        let realm = try! Realm()
        modelList = realm.objects(Model.self)
    }
    
    
    // MARK: - Public methods
    
    func provideStatistics() {
        getStatisticsOfRealm()
        presenter.getStatistics(activeGoals: activeGoals, doneGoals: doneGoals, undoneGoals: undoneGoals)
    }
    
    func getStatisticsOfRealm()  {
        guard modelList.count != 0 else {return}
        for index in 0...modelList.count - 1 {
            switch modelList[index].statusModel {
            case "Active":
                activeGoals += 1
            case "Done":
                doneGoals += 1
            case "Unfulfilled":
                undoneGoals += 1
            default:
                print("Error")
            }
            
        }
        
    }
    
}
