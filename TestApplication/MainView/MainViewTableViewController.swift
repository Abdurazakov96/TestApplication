//
//  MainTableViewController.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import UIKit

protocol MainViewInputProtocol: class {
    func GoRouter()
    
}

class MainViewTableViewController: UITableViewController {
    
    
    var presenter: MainViewOutputProtocol!
    private let configurator: MainViewConfiguratorProtocol = MainViewConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addItemVC = segue.destination as? AddItemViewViewController {
            let confugurator: AddItemViewConfiguratorProtocol = AddItemViewConfigurator()
            confugurator.configure(with: addItemVC)
        } else {
            guard let DetailViewVC = segue.destination as? DetailsViewViewController else {return}
            let confugurator: DetailsViewConfiguratorProtocol = DetailsViewConfugurator()
            guard let task = presenter.task else { return }
            confugurator.configure(with: DetailViewVC, task: task)
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.taskCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
    
    @IBAction func OpenAddItemVC(_ sender: Any) {
        presenter.openMainViewRouter()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completion) in
            self.presenter.deleteTask(at: indexPath)
            tableView.reloadData()
            completion(true)
            print("Удалено")
        }
        deleteAction.title = "Удалить"
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identificator", for: indexPath)
        
        presenter.selectRow(at: indexPath)
        cell.textLabel!.text = presenter.taskTitle
        cell.detailTextLabel!.text = presenter.taskDescription
        //        cell.imageView?.image = UIImage(data: presenter.taskImage!)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectRow(at: indexPath)
        presenter.showCourseDetails()
    }
    
    
    
}

extension MainViewTableViewController: MainViewInputProtocol {
    
    func GoRouter() {
        print("dsd")
    }
    
    
}


