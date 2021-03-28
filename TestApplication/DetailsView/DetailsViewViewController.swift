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
    
    func displayObjectTitle(with title: String)
    func displayObjectDescription(with description: String)
    func displayObjectImage(with image: Data?)
}

class DetailsViewViewController: UIViewController {
    
    // MARK: - Protocols
    
    var presenter: DetailsViewOutputProtocol!
    let configurator: DetailsViewConfiguratorProtocol =  DetailsViewConfugurator()
    
    
    // MARK: - IBoutlets
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var navigationTitle: UINavigationItem!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showDetails()
        navigationTitle.title = titleLabel.text
    }
    
}

extension DetailsViewViewController: DetailsViewInputProtocol {
    
    // MARK: - Public methods
    
    func displayObjectImage(with image: Data?) {
        self.image.image = UIImage(data: image!)
    }

    
    func displayObjectTitle(with title: String) {
        titleLabel.text = title
    }
    
    func displayObjectDescription(with description: String) {
        descriptionLabel.text = description
    }
    
}
