//
//  MainTableViewController.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import UIKit

protocol MainViewInputProtocol: class {
    
}

class MainTableViewController: UITableViewController {

    
    var presenter: CourseListPresentorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identificator", for: indexPath)
//        cell.imageView = nil
        cell.textLabel!.text = "Title"
        cell.detailTextLabel!.text = "Description"
         

        return cell
    }
    


}

extension MainTableViewController: MainViewInputProtocol {
    
}


