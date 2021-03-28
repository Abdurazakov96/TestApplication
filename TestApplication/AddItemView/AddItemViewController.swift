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
    
    func showAlert()
}

class AddItemViewViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var chooseButton: UIButton!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    // MARK: - Protocol
    
    var presenter: AddItemViewOutputProtocol!
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        addDoneButtonToTextField(titleTextField)
        addDoneButtonToTextView(descriptionTextView)
        registerForKeyboardNotifications()
        setupElements()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func chooseAPhoto(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("Please select an action", comment: "Пожалуйста выберите действие"), message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Отмена"), style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibrary = UIAlertAction(title: NSLocalizedString("Library", comment: "Библиотека"), style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alert.addAction(photoLibrary)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: "Камера"), style: .default) {action in
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                imagePicker.showsCameraControls = true
                self.present(imagePicker, animated: true)
            }
            alert.addAction(camera)
        }
        present(alert, animated: true)
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        presenter.saveData(imageData: (image.image?.jpegData(compressionQuality: 1.0)) ?? nil, title: titleTextField.text ?? nil, description: descriptionTextView.text ?? nil)
    }
    
    
    // MARK: - Private methods
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func initializeHideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupElements() {
        chooseButton.setTitle(NSLocalizedString("Choose a photo", comment: "Выбрать фотографию"), for: .normal)
        navigationItem.title = NSLocalizedString("Adding a goals", comment: "Добавление цели")
        doneButton.title = NSLocalizedString("Done", comment: "Готово")
        titleTextField.placeholder = NSLocalizedString("Enter goal name", comment: "Введите название цели")
        descriptionTextView.text = NSLocalizedString("Enter goal description", comment: "Введите описание цели")
    }
    
    
    // MARK: - Objc private method
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.scrollview.contentOffset == CGPoint.zero {
                self.scrollview.contentOffset = CGPoint(x: 0, y: keyboardSize.height + 70)
            }
            
        }
        
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.scrollview.contentOffset = CGPoint.zero
    }
    
    @objc private func dismisskeyboard() {
        view.endEditing(true)
    }
    
}

extension AddItemViewViewController: AddItemViewInputProtocol {
    
    // MARK: - Public methods
    
    func showAlert() {
        let alert = UIAlertController(title: "Заполните все поля", message: nil , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}

extension AddItemViewViewController: UIImagePickerControllerDelegate {
    
    // MARK: - Public method
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else { return  }
        
        image.image = selectedImage
        image.contentMode = .scaleToFill
        dismiss(animated: true)
    }
    
}

extension AddItemViewViewController: UINavigationControllerDelegate{
    
}

extension AddItemViewViewController: UITextFieldDelegate {
    
    // MARK: - Private method
    
    private func addDoneButtonToTextField(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "ОК",
           
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDoneInTextField))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    
    // MARK: - Objc private method
    
    @objc private func didTapDoneInTextField() {
        view.endEditing(true)
    }
    
}


extension AddItemViewViewController: UITextViewDelegate {
    
    // MARK: - Private method
    
    private func addDoneButtonToTextView(_ textView: UITextView) {
        
        let keyboardToolbar = UIToolbar()
        textView.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "ОК",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDoneInTextField))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        descriptionTextView.text = ""
        return true
    }
      
}
