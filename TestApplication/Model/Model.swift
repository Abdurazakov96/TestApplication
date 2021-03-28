//
//  Model.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//


import Foundation
import RealmSwift

class Model: Object {
    
    // MARK: - Public Properties
    
    @objc dynamic var title: String?
    @objc dynamic var descriptionForTitle: String?
    @objc dynamic var image: Data?
    @objc dynamic var statusModel: String?
}
