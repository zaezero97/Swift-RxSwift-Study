//
//  TaskListViewController.swift
//  GoodListApp
//
//  Created by 재영신 on 2021/12/15.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class TaskListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let tasks = BehaviorRelay<[Task]>(value: [])
    var filterTasks = [Task]() {
        didSet {
            print("filterTasks!!! ->", filterTasks)
        }
    }
    @IBOutlet weak var taskListTableView: UITableView! {
        didSet {
            taskListTableView.delegate = self
            taskListTableView.dataSource = self
        }
    }
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addTaskVC = segue.destination as? AddTaskViewController else {
            print("AddTaskViewController not fount 🤣")
            return
        }
        
        addTaskVC.taskSubjectObservable.subscribe(onNext: {
            task in
            
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            
            var existingTasks = self.tasks.value
            existingTasks.append(task)
            self.tasks.accept(existingTasks)
        
            self.filterTasks(by: priority)
            print(task)
        }) { error in
            print(error.localizedDescription)
        } onCompleted: {
            print("onCompleted")
        } onDisposed: {
            print("onDisposed")
        }.disposed(by: disposeBag)

    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filterTasks = self.tasks.value
            self.taskListTableView.reloadData()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority }
            }.take(1).subscribe(onNext: {
                self.filterTasks = $0
                self.taskListTableView.reloadData()
            }, onCompleted: {
                print("map onCompleted!!!")
            })
            
        }
    }
    @IBAction func priorityValueChanged(_ sender: UISegmentedControl) {
        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
}


extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.filterTasks[indexPath.row].title
        
        return cell
    }
    
    
}
