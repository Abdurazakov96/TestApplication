//
//  MainPresentor.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 08.07.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import Foundation

protocol MainViewOutputProtocol: class {
    var taskCount: Int { get }
    var taskTitle: String? { get }
    var taskDescription: String? { get }
    var taskImage: Data? { get }
    var task: Model? { get }
    func openMainViewRouter()
    func selectRow(at indexPath: IndexPath)
    func deleteTask(at indexPath: IndexPath)
    func showCourseDetails()
}

protocol MainViewInteractorOutputProtocol: class {
    
}

class MainViewPresentor: MainViewOutputProtocol, MainViewInteractorOutputProtocol  {
    
    func showCourseDetails() {
        guard let task = task else { return }
        router.openDetailViewViewController(task: task)
    }
    
    
    var task: Model? {
        guard let indexPath = indexPath else { return nil }
        return getTask(at: indexPath)
    }
    
    private func getTask(at indexPath: IndexPath) -> Model? {
        if arrayOfTasks.indices.contains(indexPath.row) {
            return arrayOfTasks[indexPath.row]
        }
        
        return nil
    }
    
    func deleteTask(at indexPath: IndexPath) {
        if arrayOfTasks.indices.contains(indexPath.row) {
            arrayOfTasks.remove(at: indexPath.row)
        }
    }
    
    
    var taskImage: Data?{
        guard let indexPath = indexPath else { return nil }
        return getTaskImage(at: indexPath)
    }
    
    var taskDescription: String?{
        guard let indexPath = indexPath else { return nil }
        return getTaskDescription(at: indexPath)
    }
    
    var taskTitle: String?{
        guard let indexPath = indexPath else { return nil }
        return getTaskTitle(at: indexPath)
    }
    
    private func getTaskTitle(at indexPath: IndexPath) -> String? {
        if arrayOfTasks.indices.contains(indexPath.row) {
            return arrayOfTasks[indexPath.row].title!
        }
        
        return nil
    }
    
    private func getTaskDescription(at indexPath: IndexPath) -> String? {
        if arrayOfTasks.indices.contains(indexPath.row) {
            return arrayOfTasks[indexPath.row].description!
        }
        
        return nil
    }
    
    private func getTaskImage(at indexPath: IndexPath) -> Data? {
        if arrayOfTasks.indices.contains(indexPath.row) {
            return arrayOfTasks[indexPath.row].data
        }
        
        return nil
    }
    
    
    func selectRow(at indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    
    
    private var indexPath: IndexPath?
    
    var taskCount: Int {
        arrayOfTasks.count
    }
    
    var arrayOfTasks: [Model] = [Model(title: "first Task", description: "sdsad", data: nil), Model(title: "second Task", description: "second description", data: nil)]
    
    func openMainViewRouter() {
        router.openAddItemViewController()
    }
    
    required init(view: MainViewInputProtocol) {
        self.view = view
    }
    
    unowned let view: MainViewInputProtocol!
    var interactor: MainViewInteractorInputProtocol!
    var router: MainViewRouterProtocol!
    
    
}
