//
//  AddItemViewController.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import UIKit

protocol AddItemViewInputProtocol: class {
    
    // MARK: - Public method
    
    func activateAlert()
}

class AddItemViewViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    
    // MARK: - Public property
    
    var presenter: AddItemViewOutputProtocol!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapForImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //   let MainViewTableVC = segue.destination as! MainViewTableViewController
        //        let configurator: CourseDetailsConfiguratorProtocol = CourseDetailsConfigurator()
        //        guard let course = presenter.course else { return }
        //        confugurator.configure(with: detailVC, and: course)
    }
    
    
    // MARK: - Public method
    
    private func addTapForImage() {
        image.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        tapGestureRecognizer.numberOfTapsRequired = 1
        image.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    // MARK: - objc method
    
    @objc func selectImage(_ sender: UITapGestureRecognizer) {
        
        
        let alert = UIAlertController(title: "Please choose image source", message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibrary = UIAlertAction(title: "PhotoLibrary", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alert.addAction(photoLibrary)
        }
        present(alert, animated: true)
    }
    
    
    // MARK: - IBAction
    
    @IBAction func addTask(_ sender: Any) {
        presenter.saveData(imageData: (image.image?.pngData())!, title: titleTextField.text ?? nil, description: descriptionTextView.text ?? nil)
    }
    
}

extension AddItemViewViewController: AddItemViewInputProtocol {
    
    // MARK: - Public methods
    
    func activateAlert() {
        let alert = UIAlertController(title: "Заполните все поля", message: nil , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}

extension AddItemViewViewController: UIImagePickerControllerDelegate {
    
    // MARK: - Public methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else { return  }
        
        image.image = selectedImage
        dismiss(animated: true)
    }
    
}

extension AddItemViewViewController: UINavigationControllerDelegate{
    
}
