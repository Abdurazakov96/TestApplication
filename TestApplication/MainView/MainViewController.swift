//
//  MainViewController.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 06.10.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import UIKit

protocol MainViewInputProtocol: class {
    
    // MARK: - Public method
    
    func refreshTable()
}

class MainViewController: UIViewController, MainViewInputProtocol, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    
    // MARK: - Protocols
    
    var presenter: MainViewOutputProtocol!
    var presenterForAddItemVC: AddItemVCProtocol!
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tabBar: UITabBar!
    @IBOutlet var editActionBarButton: UIBarButtonItem!
    @IBOutlet var tabBarFirst: UITabBarItem!
    @IBOutlet var tabBarThird: UITabBarItem!
    @IBOutlet var tabBarSecond: UITabBarItem!
    @IBOutlet var tabBarFourth: UITabBarItem!
    
    
    // MARK: - Private class
    
    private let configurator: MainViewConfiguratorProtocol = MainViewConfigurator()
    
    
    // MARK: - Private properties
    
    private var statusModel = "Active"
    private var arrayOfActionModel: [Int] = []
    private var arrayOfDoneModel: [Int] = []
    private var arrayOfUnfulfilledModel: [Int] = []
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupElements()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let AddItemVC = segue.destination as? AddItemViewViewController {
            let confugurator: AddItemViewConfiguratorProtocol = AddItemViewConfigurator()
            confugurator.configure(with: AddItemVC, MainViewTCprotocol: presenterForAddItemVC)
            
        } else if let AnalizVC = segue.destination as? AnalizViewController {
            let configurator: AnalizViewConfiguratorProtocol = AnalizViewConfugurator()
            configurator.configure(with: AnalizVC)
        }
            
        else {
            guard let DetailViewVC = segue.destination as? DetailsViewViewController else {return}
            let confugurator: DetailsViewConfiguratorProtocol = DetailsViewConfugurator()
            guard let indexPath = presenter.indexPathForDetailVC else { return }
            confugurator.configure(with: DetailViewVC, indexPath: indexPath)
        }
        
    }
    
    
    
    // MARK: - IBActions
    
    @IBAction func OpenAddItemVC(_ sender: Any) {
        presenter.openMainViewRouter()
    }
    
    @IBAction func editAction(_ sender: Any) {
        if statusModel == "Active" && arrayOfActionModel.count != 0 || statusModel == "Done"  && arrayOfDoneModel.count != 0 || statusModel == "Unfulfilled" && arrayOfUnfulfilledModel.count != 0 {
            tableView.setEditing(!tableView.isEditing, animated: true)
            if tableView.isEditing {
                editActionBarButton.title = NSLocalizedString("Cancel", comment: "Отмена")
            } else {
                editActionBarButton.title = NSLocalizedString("Change", comment: "Изменить")
            }
        } else {
            editActionBarButton.title = NSLocalizedString("Change", comment: "Изменить")
        }
    }
    
    
    // MARK: - Private methods
    
    private func setupElements(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tabBar.delegate = self
        tabBarFirst.title = NSLocalizedString("Active", comment: "Активные")
        tabBarSecond.title = NSLocalizedString("Completed", comment: "Выполненные")
        tabBarThird.title = NSLocalizedString("Unfulfilled", comment: "Невыполненные")
        tabBarThird.title = NSLocalizedString("Unfulfilled", comment: "Невыполненные")
        tabBarFourth.title = NSLocalizedString("Statistics", comment: "Статистика")
        editActionBarButton.title = NSLocalizedString("Change", comment: "Изменить")
        navigationItem.title = NSLocalizedString("Goals", comment: "Цели")
    }
    
    private func refreshArray(indexPath: IndexPath) {
        
        self.presenter.selectRow(at: indexPath)
        
        var sum = 0
        
        if self.presenter.objectStatus == "Active" {
            if self.arrayOfActionModel.count != 0 {
                for index in 0...self.arrayOfActionModel.count - 1 {
                    if self.arrayOfActionModel[index] == indexPath.row {
                        sum += 1
                    }
                    
                }
                
                if sum == 0 {
                    self.arrayOfActionModel.append(indexPath.row)
                }
                
            } else {
                self.arrayOfActionModel.append(indexPath.row)
            }
            
        } else if self.presenter.objectStatus == "Done" {
            if self.arrayOfDoneModel.count != 0 {
                for index in 0...self.arrayOfDoneModel.count - 1 {
                    if self.arrayOfDoneModel[index] == indexPath.row {
                        sum += 1
                    }
                    
                }
                
                if sum == 0 {
                    self.arrayOfDoneModel.append(indexPath.row)
                }
                
            } else {
                self.arrayOfDoneModel.append(indexPath.row)
            }
            
        } else if self.presenter.objectStatus == "Unfulfilled" {
            if self.arrayOfUnfulfilledModel.count != 0 {
                for index in 0...self.arrayOfUnfulfilledModel.count - 1 {
                    if self.arrayOfUnfulfilledModel[index] == indexPath.row {
                        sum += 1
                    }
                    
                }
                
                if sum == 0 {
                    self.arrayOfUnfulfilledModel.append(indexPath.row)
                }
                
            } else {
                self.arrayOfUnfulfilledModel.append(indexPath.row)
            }
            
        }
        
    }
    
    private func deleteActionForArray(arrayFirst: Array<Int>, arraySecond: Array<Int>, indexPath: IndexPath, arrayFirstName: String) {
        
        var arrayF = arrayFirst
        var arrayS = arraySecond
        
        for index in 0...arrayF.count - 1  {
            if arrayF.count != 0 {
                if index < arrayF.count {
                    if indexPath.row == arrayF[index]   {
                        arrayF.remove(at: index)
                        self.presenter.deleteModel(at: indexPath)
                        if arrayF.count != 0 {
                            for indexSecond in 0...arrayF.count - 1 {
                                if indexPath.row < arrayF[indexSecond] {
                                    arrayF[indexSecond] = arrayF[indexSecond] - 1
                                }
                                
                            }
                            
                        }
                        
                        if self.arrayOfActionModel.count != 0 {
                            for indexSecond in 0...self.arrayOfActionModel.count - 1 {
                                if indexPath.row < self.arrayOfActionModel[indexSecond] {
                                    self.arrayOfActionModel[indexSecond] -= 1
                                }
                                
                            }
                            
                        }
                        
                        if arrayS.count != 0 {
                            for indexSecond in 0...arrayS.count - 1 {
                                if indexPath.row < arrayS[indexSecond] {
                                    arrayS[indexSecond] -= 1
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        if arrayFirstName == "arrayOfDoneModel" {
            self.arrayOfDoneModel = arrayF
            self.arrayOfUnfulfilledModel = arrayS
        } else {
            self.arrayOfDoneModel = arrayS
            self.arrayOfUnfulfilledModel = arrayF
        }
        
    }
    
    
    // MARK: - Public Methods
    
    func refreshTable() {
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.objectCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var status = false
        if statusModel == "Active" {
            if arrayOfActionModel.count != 0 {
                for index in 0...arrayOfActionModel.count - 1{
                    if  indexPath.row == arrayOfActionModel[index] {
                        status = true
                    }
                    
                }
                
                if status == true {
                    return UITableView.automaticDimension
                } else {
                    return 0
                }
                
            } else {
                return 0
            }
            
        } else if statusModel == "Done" {
            if arrayOfDoneModel.count != 0 {
                for index in 0...arrayOfDoneModel.count - 1{
                    if  indexPath.row == arrayOfDoneModel[index] {
                        status = true
                    }
                    
                }
                
                if status == true {
                    return UITableView.automaticDimension
                } else {
                    return 0
                }
                
            } else {
                return 0
            }
            
        } else if statusModel == "Unfulfilled" {
            if arrayOfUnfulfilledModel.count != 0 {
                for index in 0...arrayOfUnfulfilledModel.count - 1{
                    if  indexPath.row == arrayOfUnfulfilledModel[index] {
                        status = true
                    }
                    
                }
                
                if status == true {
                    return UITableView.automaticDimension
                } else {
                    return 0
                }
                
            } else {
                return 0
            }
            
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let unfulfilledAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Not done", comment: "Не выполнена")) { (action, view, completion) in
            
            self.arrayOfActionModel = []
            self.arrayOfDoneModel = []
            self.arrayOfUnfulfilledModel = []
            
            self.refreshArray(indexPath: indexPath)
            
            for index in 0...self.arrayOfActionModel.count - 1  {
                if index < self.arrayOfActionModel.count {
                    if indexPath.row == self.arrayOfActionModel[index]   {
                        self.arrayOfActionModel.remove(at: index)
                        self.presenter.unfulfilledModel(at: indexPath)
                        tableView.reloadData()
                        
                        if self.arrayOfActionModel.count != 0 {
                            for indexSecond in 0...self.arrayOfActionModel.count - 1 {
                                if indexPath.row < self.arrayOfActionModel[indexSecond] {
                                    self.arrayOfActionModel[indexSecond] = self.arrayOfActionModel[indexSecond] - 1
                                }
                                
                            }
                            
                        }
                        
                        if self.arrayOfDoneModel.count != 0 {
                            for indexSecond in 0...self.arrayOfDoneModel.count - 1 {
                                if indexPath.row < self.arrayOfDoneModel[indexSecond] {
                                    self.arrayOfDoneModel[indexSecond] -= 1
                                }
                                
                            }
                            
                        }
                        
                        if self.arrayOfUnfulfilledModel.count != 0 {
                            for indexSecond in 0...self.arrayOfUnfulfilledModel.count - 1 {
                                if indexPath.row < self.arrayOfUnfulfilledModel[indexSecond] {
                                    self.arrayOfUnfulfilledModel[indexSecond] -= 1
                                }
                                
                            }
                            
                        }
                        
                        self.arrayOfActionModel = []
                        self.arrayOfDoneModel = []
                        self.arrayOfUnfulfilledModel = []
                        self.refreshArray(indexPath: indexPath)
                    }
                    
                }
                
            }
            
            tableView.reloadData()
            completion(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "Удалить")) { (action, view, completion) in
            
            self.arrayOfActionModel = []
            self.arrayOfDoneModel = []
            self.arrayOfUnfulfilledModel = []
            
            self.refreshArray(indexPath: indexPath)
            
            if self.statusModel == "Done" {
                
                self.deleteActionForArray(arrayFirst: self.arrayOfDoneModel, arraySecond: self.arrayOfUnfulfilledModel, indexPath: indexPath, arrayFirstName: "arrayOfDoneModel")
            } else {
                self.deleteActionForArray(arrayFirst: self.arrayOfUnfulfilledModel, arraySecond: self.arrayOfDoneModel, indexPath: indexPath, arrayFirstName: "arrayOfUnfulfilledModel")
            }
            
            tableView.reloadData()
            completion(true)
        }
        
        deleteAction.title = NSLocalizedString("Delete", comment: "Удалить")
        
        let doneAction = UIContextualAction(style: .normal, title: NSLocalizedString("Done", comment: "Выполнена")) { (action, view, completion) in
            
            for index in 0...self.arrayOfActionModel.count - 1  {
                if index < self.arrayOfActionModel.count {
                    if indexPath.row == self.arrayOfActionModel[index]   {
                        self.arrayOfActionModel.remove(at: index)
                        self.presenter.doneModel(at: indexPath)
                        tableView.reloadData()
                        
                        if self.arrayOfActionModel.count != 0 {
                            for indexSecond in 0...self.arrayOfActionModel.count - 1 {
                                if indexPath.row < self.arrayOfActionModel[indexSecond] {
                                    self.arrayOfActionModel[indexSecond] = self.arrayOfActionModel[indexSecond] - 1
                                }
                                
                            }
                            
                        }
                        
                        if self.arrayOfDoneModel.count != 0 {
                            for indexSecond in 0...self.arrayOfDoneModel.count - 1 {
                                if indexPath.row < self.arrayOfDoneModel[indexSecond] {
                                    self.arrayOfDoneModel[indexSecond] -= 1
                                }
                                
                            }
                            
                        }
                        
                        if self.arrayOfUnfulfilledModel.count != 0 {
                            for indexSecond in 0...self.arrayOfUnfulfilledModel.count - 1 {
                                if indexPath.row < self.arrayOfUnfulfilledModel[indexSecond] {
                                    self.arrayOfUnfulfilledModel[indexSecond] -= 1
                                }
                                
                            }
                            
                        }
                        
                        self.arrayOfActionModel = []
                        self.arrayOfDoneModel = []
                        self.arrayOfUnfulfilledModel = []
                        
                        self.refreshArray(indexPath: indexPath)
                    }
                    
                }
                
            }
            
            tableView.reloadData()
            completion(true)
        }
        
        doneAction.title = NSLocalizedString("Done", comment: "Выполнена цель в таблице")
        
        if statusModel == "Active" {
            return UISwipeActionsConfiguration(actions: [doneAction, unfulfilledAction])
        } else if statusModel == "Done" {
            return UISwipeActionsConfiguration(actions: [deleteAction])
        } else if statusModel == "Unfulfilled" {
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        tableView.reloadData()
        return UISwipeActionsConfiguration(actions: [deleteAction, doneAction])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identificator", for: indexPath) as? MainViewTableViewCell
        
        presenter.selectRow(at: indexPath)
        
        cell?.titleLabel?.text = presenter.objectTitle
        cell?.descriptionLabel?.text = presenter.objectDescription
        cell?.objectImage?.image = UIImage(data: presenter.objectImage!)
        
        refreshArray(indexPath: indexPath)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectRow(at: indexPath)
        presenter.showDetail()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == NSLocalizedString("Active", comment: "Активные") {
            editActionBarButton.title = NSLocalizedString("Change", comment: "Изменить")
            tableView.isEditing = false
            statusModel = "Active"
            tableView.reloadData()
            tabBar.tintColor = .init(red: 203/255, green: 222/255, blue: 33/255, alpha: 1.0)
        } else if item.title == NSLocalizedString("Completed", comment: "Выполненные") {
            editActionBarButton.title = NSLocalizedString("Change", comment: "Изменить")
            tableView.isEditing = false
            statusModel = "Done"
            tableView.reloadData()
            tabBar.tintColor = .green
        } else if item.title == NSLocalizedString("Unfulfilled", comment: "Невыполненные") {
            editActionBarButton.title = NSLocalizedString("Change", comment: "Изменить")
            tableView.isEditing = false
            statusModel = "Unfulfilled"
            tableView.reloadData()
            tabBar.tintColor = .red
        } else if item.title == NSLocalizedString("Statistics", comment: "Невыполненные"){
            tabBar.tintColor = .blue
            if arrayOfDoneModel.count != 0 || arrayOfActionModel.count != 0 || arrayOfUnfulfilledModel.count != 0 {

                presenter.openAnalizVC()
            } else {

                let alert = UIAlertController(title: NSLocalizedString("Missing data for statistics", comment: "Отсутствуют данные для статистики"), message: nil , preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
            }
            
        }
        
    }
    
}


