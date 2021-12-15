//
//  AddTaskViewController.swift
//  GoodListApp
//
//  Created by 재영신 on 2021/12/15.
//

import Foundation
import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickSaveButton(_ sender: Any) {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex), let title = taskTitleTextField.text
        else { return }
        
        taskSubject.onNext(Task(title: title, priority: priority))
        self.navigationController?.popViewController(animated: true)
    }
}
