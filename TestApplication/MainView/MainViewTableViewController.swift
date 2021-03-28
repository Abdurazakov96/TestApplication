//
//  MainTableViewController.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

//import UIKit
//
//protocol MainViewInputProtocolS: class {
//    
//    // MARK: - Public method
//    
//    func refreshTable()
//}
//
//
//class MainViewTableViewController: UITableViewController, MainViewInputProtocol {
//    
//    // MARK: - Private property
//    
//    private let configurator: MainViewConfiguratorProtocol = MainViewConfigurator()
//    
//    @IBOutlet var tabbard: UITabBar!
//    
//    // MARK: - Public property
//    
//    var presenter: MainViewOutputProtocol!
//    var presenterForAddItemVC: AddItemVCProtocol!
//
//    // MARK: - Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      //  configurator.configure(with: self)
//        tableView.separatorColor = UIColor.clear
//        print("sadsadsadasd + \(presenter.objectCount)")
//    }
//    
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
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.objectCount ?? 0
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return UITableView.automaticDimension
//    }
//    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completion) in
//            self.presenter.deleteModel(at: indexPath)
//            tableView.reloadData()
//            completion(true)
//            print("Удалено")
//        }
//        deleteAction.title = "Удалить"
//        
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "identificator", for: indexPath) as? MainViewTableViewCell
//        
//        presenter.selectRow(at: indexPath)
//        
//     //   cell?.titleLabel?.text = presenter.objectTitle
////        cell?.descriptionLabel?.text = presenter.objectDescription
////        cell?.objectImage?.image = UIImage(data: presenter.objectImage!)
//        
//
//        return cell!
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        presenter.selectRow(at: indexPath)
//        presenter.showDetail()
//    }
//    
//    
//    // MARK: - Public method
//    
//    func refreshTable() {
//        tableView.reloadData()
//    }
//    
//    // MARK: - IBAction
//    
//    @IBAction func OpenAddItemVC(_ sender: Any) {
//        presenter.openMainViewRouter()
//        switch tabbard.selectedItem?.title {
//            
//        case "R":
//            print("R")
//        case "S":
//            print("S")
//
//        case .none:
//            print("Nichego")
//        case .some(_):
//            print("Nichego")
//        }
//    }
//    
//}




