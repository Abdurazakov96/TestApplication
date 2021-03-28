////
////  MainViewController.swift
////  TestApplication
////
////  Created by Магомед Абдуразаков on 06.10.2020.
////  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
////
//
//import UIKit
//
//protocol MainViewInputProtocol: class {
//    
//    // MARK: - Public method
//    
//    func refreshTable()
//}
//
//class MainViewController: UIViewController, MainViewInputProtocol, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
//    
//    private let configurator: MainViewConfiguratorProtocol = MainViewConfigurator()
//    
//    
//    // MARK: - Public property
//    
//    var presenter: MainViewOutputProtocol!
//    var presenterForAddItemVC: AddItemVCProtocol!
//    var bool = true
//    var arrayOfActionModel: [Int] = []
//    var arrayOfDoneModel: [Int] = []
//    
//    func refreshTable() {
//        tableView.reloadData()
//        print("array of Action \(self.arrayOfActionModel)")
//        print("array of Done \(self.arrayOfDoneModel)")
//    }
//    
//    @IBOutlet var tableView: UITableView!
//    @IBOutlet var tabBar: UITabBar!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        configurator.configure(with: self)
//        tableView.separatorColor = UIColor.clear
//        tabBar.delegate = self
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if let addItemVC = segue.destination as? AddItemViewViewController {
//            let confugurator: AddItemViewConfiguratorProtocol = AddItemViewConfigurator()
//            confugurator.configure(with: addItemVC, MainViewTCprotocol: presenterForAddItemVC)
//        } else {
//            guard let DetailViewVC = segue.destination as? DetailsViewViewController else {return}
//            let confugurator: DetailsViewConfiguratorProtocol = DetailsViewConfugurator()
//            guard let indexPath = presenter.indexPathForDetailVC else { return }
//            confugurator.configure(with: DetailViewVC, indexPath: indexPath)
//        }
//    }
//    
//    @IBAction func OpenAddItemVC(_ sender: Any) {
//        presenter.openMainViewRouter()
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.objectCount ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var status = false
//        if bool == true {
//            if arrayOfActionModel.count != 0 {
//                for index in 0...arrayOfActionModel.count - 1{
//                    if  indexPath.row == arrayOfActionModel[index] {
//                        status = true
//                    }
//                }
//                if status == true {
//                    return UITableView.automaticDimension
//                } else {
//                    return 0
//                }
//            }
//            else {
//                return 0
//            }
//        }else if bool == false {
//            if arrayOfDoneModel.count != 0 {
//                for index in 0...arrayOfDoneModel.count - 1{
//                    if  indexPath.row == arrayOfDoneModel[index] {
//                        status = true
//                    }
//                }
//                if status == true {
//                    return UITableView.automaticDimension
//                } else {
//                    return 0
//                }
//            }
//            else {
//                return 0
//            }
//        }
//        
//        
//        return UITableView.automaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completion) in
//            
//            self.arrayOfActionModel = []
//            self.arrayOfDoneModel = []
//            
//            self.refreshArray(indexPath: indexPath)
//            
//            for index in 0...self.arrayOfDoneModel.count - 1  {
//                if self.arrayOfDoneModel.count != 0 {
//                    if index < self.arrayOfDoneModel.count {
//                        if indexPath.row == self.arrayOfDoneModel[index]   {
//                            print("1")
//                            self.arrayOfDoneModel.remove(at: index)
//                            self.presenter.deleteModel(at: indexPath)
//                            
//                            
//                            
//                            
//                            
//                            if self.arrayOfDoneModel.count != 0 {
//                                print("2")
//                                for indexSecond in 0...self.arrayOfDoneModel.count - 1 {
//                                    print("3")
//                                    if indexPath.row < self.arrayOfDoneModel[indexSecond] {
//                                        
//                                        self.arrayOfDoneModel[indexSecond] = self.arrayOfDoneModel[indexSecond] - 1
//                                        print("4")
//                                     
//                                    }
//                                    print("5")
//                                }
//                                print("6")
//                            }
//                            
//                            print("7")
//                            if self.arrayOfActionModel.count != 0 {
//                                for indexSecond in 0...self.arrayOfActionModel.count - 1 {
//                                    if indexPath.row < self.arrayOfActionModel[indexSecond] {
//                                        self.arrayOfActionModel[indexSecond] -= 1
//                                    }
//                                    
//                                }
//                            }
//                            
////                            self.arrayOfActionModel = []
////                            self.arrayOfDoneModel = []
////
////                            self.refreshArray(indexPath: indexPath)
//                        }
//                    }
//                }
//            }
//            
//            tableView.reloadData()
//            completion(true)
//            //            print("Удалено")
//            
//            
//        }
//        deleteAction.title = "Удалить"
//        
//        let doneAction = UIContextualAction(style: .normal, title: "Выполнена") { (action, view, completion) in
//            
//            
//            
//            
//            for index in 0...self.arrayOfActionModel.count - 1  {
//                if index < self.arrayOfActionModel.count {
//                    if indexPath.row == self.arrayOfActionModel[index]   {
//                        //                     print(self.arrayOfActionModel.count)
//                        self.arrayOfActionModel.remove(at: index)
//                        
//                        self.presenter.doneModel(at: indexPath)
//                        tableView.reloadData()
//                        
//                        if self.arrayOfActionModel.count != 0 {
//                            print("count \(self.arrayOfActionModel.count)")
//                            for indexSecond in 0...self.arrayOfActionModel.count - 1 {
//                                if indexPath.row < self.arrayOfActionModel[indexSecond] {
//                                    self.arrayOfActionModel[indexSecond] = self.arrayOfActionModel[indexSecond] - 1
//                                    
//                                }
//                                
//                            }
//                        }
//                        
//                        
//                        if self.arrayOfDoneModel.count != 0 {
//                            for indexSecond in 0...self.arrayOfDoneModel.count - 1 {
//                                if indexPath.row < self.arrayOfDoneModel[indexSecond] {
//                                    self.arrayOfDoneModel[indexSecond] -= 1
//                                }
//                                
//                            }
//                        }
//                        
//                        self.arrayOfActionModel = []
//                        self.arrayOfDoneModel = []
//                        
//                        self.refreshArray(indexPath: indexPath)
//                        
//                        
//                        print("array ofACTION \(self.arrayOfActionModel)")
//                        print("array ofDONDE \(self.arrayOfDoneModel)")
//                        
//                    }
//                }
//            }
//            
//            print("array of Action \(self.arrayOfActionModel)")
//            print("array of Done \(self.arrayOfDoneModel)")
//            //
//            tableView.reloadData()
//            completion(true)
//            //                print(self.arrayOfActionModel)
//        }
//        
//        doneAction.title = "Выполнено"
//        
//        
//        
//        if bool == true {
//            return UISwipeActionsConfiguration(actions: [doneAction])
//        } else {
//            return UISwipeActionsConfiguration(actions: [deleteAction])
//        }
//        
//        tableView.reloadData()
//        return UISwipeActionsConfiguration(actions: [deleteAction, doneAction])
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "identificator", for: indexPath) as? MainViewTableViewCell
//        
//        
//        
//        presenter.selectRow(at: indexPath)
//        
//        cell?.titleLabel?.text = presenter.objectTitle
//        cell?.descriptionLabel?.text = presenter.objectDescription
//        cell?.objectImage?.image = UIImage(data: presenter.objectImage!)
//     
//        
//        
//        refreshArray(indexPath: indexPath)
//        
//        //        print("arrayOfActionModel = \(arrayOfActionModel)")
//        //        print("arrayOfDoneModel = \(arrayOfDoneModel)")
//        return cell!
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        presenter.selectRow(at: indexPath)
//        presenter.showDetail()
//    }
//    
//    @IBOutlet var editActionBarButton: UIBarButtonItem!
//    
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item.title == "Активные" {
//            editActionBarButton.title = "Изменить"
//            tableView.isEditing = false
//            bool = true
//            tableView.reloadData()
//            print("array of Action \(self.arrayOfActionModel)")
//            print("array of Done \(self.arrayOfDoneModel)")
//        }
//        else if item.title == "Выполненные" {
//            editActionBarButton.title = "Изменить"
//            tableView.isEditing = false
//            bool = false
//            tableView.reloadData()
//            print("array of Action \(self.arrayOfActionModel)")
//            print("array of Done \(self.arrayOfDoneModel)")
//        }
//        else {
//            
//        }
//    }
//    
//    func  refreshArray(indexPath: IndexPath) {
//        
//        self.presenter.selectRow(at: indexPath)
//        
//        var sum = 0
//        
//        if self.presenter.objectStatus == true {
//            if self.arrayOfActionModel.count != 0 {
//                for index in 0...self.arrayOfActionModel.count - 1 {
//                    if self.arrayOfActionModel[index] == indexPath.row {
//                        sum += 1
//                    }
//                }
//                if sum == 0 {
//                    self.arrayOfActionModel.append(indexPath.row)
//                }
//                
//            } else {
//                self.arrayOfActionModel.append(indexPath.row)
//            }
//        } else {
//            if self.arrayOfDoneModel.count != 0 {
//                for index in 0...self.arrayOfDoneModel.count - 1 {
//                    if self.arrayOfDoneModel[index] == indexPath.row {
//                        sum += 1
//                    }
//                }
//                if sum == 0 {
//                    self.arrayOfDoneModel.append(indexPath.row)
//                }
//                
//            } else {
//                self.arrayOfDoneModel.append(indexPath.row)
//            }
//            
//        }
//    }
//    
//    
//    
//    @IBAction func editAction(_ sender: Any) {
//        if bool && arrayOfActionModel.count != 0 || bool == false && arrayOfDoneModel.count != 0 {
//        tableView.setEditing(!tableView.isEditing, animated: true)
//        if tableView.isEditing {
//            editActionBarButton.title = "Отмена"
//        } else {
//            editActionBarButton.title = "Изменить"
//        }
//        } else {
//            editActionBarButton.title = "Изменить"
//        }
//    }
//    
//}
