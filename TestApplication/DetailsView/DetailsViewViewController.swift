//
//  DetailsViewController.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import UIKit

protocol DetailsViewInputProtocol: class {
    
    // MARK: - Public methods
    
    func displayTaskTitle(with title: String)
    func displayTaskDescription(with description: String)
}

class DetailsViewViewController: UIViewController {
    
    // MARK: - IBoutlets
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    // MARK: - Public properties
    
    var presenter: DetailsViewPresenter!
    let configurator: DetailsViewConfiguratorProtocol =  DetailsViewConfugurator()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        configurator.configure(with: self, task: Model(title: "dd", description: "aa", data: UIImage(named: "Swift.jpg")?.pngData()))
        presenter.showDetails()
    }
        
}

extension DetailsViewViewController: DetailsViewInputProtocol {
    
        // MARK: - Public properties
    
    //    func displayTaskImage(with imageData: Data?) {
    //        image.image = UIImage(data: imageData!)
    //    }
    
    func displayTaskTitle(with title: String) {
        titleLabel.text = title
    }
    
    func displayTaskDescription(with description: String) {
        descriptionLabel.text = description
    }
    
}
