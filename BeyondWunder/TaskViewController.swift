//
//  TaskTableViewController.swift
//  BeyondWunder
//
//  Created by hoemoon on 13/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UITableViewController {
    var realm: Realm!
    var taskListId:String?
    var taskListTitle:String?
    var tasks = List<Task>()
    var notificationToken: NotificationToken?
    var sorted: Results<Task>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.notificationToken = sorted.addNotificationBlock { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self.tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0)}, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
                break
            case .error(let err):
                fatalError("\(err)")
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = taskListTitle
    }
    
    func setupUI() {
        tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCell")
        self.title = taskListTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    func add() {
        let alertController = UIAlertController(title: "New Task", message: "Enter Task Name", preferredStyle: .alert)
        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Task Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertTextField.text , !text.isEmpty else { return }
            DispatchQueue.global().async {
                let realm = try! Realm()
                let task = Task(text: text)
                let taskList = realm.object(ofType: TaskList.self, forPrimaryKey: self.taskListId)
                
                realm.beginWrite()
                realm.add(task)
                taskList?.items.append(task)
                try! realm.commitWrite()
            }
        })
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return tasks.count
//    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        let object = sorted[indexPath.row]
        cell.taskText = object.text
        cell.tag = indexPath.row
        cell.taskId = object.id
        cell.tasks = self.sorted
        cell.toggleCheck = Bool(object.completed)
        cell.realm = self.realm
        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            
            self.realm.beginWrite()
            self.realm.delete(self.tasks[indexPath.row])
            try! self.realm.commitWrite()
        })
        
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            
            let alertController = UIAlertController(title: "Edit Task List Name", message: "Enter Task List Name", preferredStyle: .alert)
            var alertTextField: UITextField!
            alertController.addTextField { textField in
                alertTextField = textField
                textField.placeholder = "Task List Name"
            }
            alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
                guard let text = alertTextField.text , !text.isEmpty else { return }
                
                let realm = self.realm!
                realm.beginWrite()
                let taskId = self.tasks[indexPath.row].id
                realm.create(Task.self, value: ["id": taskId, "text": text], update: true)
                try! realm.commitWrite()
            })
            self.present(alertController, animated: true, completion: nil)
        })
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        try! tasks.realm?.write {
            tasks.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = TaskDetailViewController()
        detailView.realm = self.realm
        detailView.task = self.sorted[indexPath.row]
        detailView.sorted = self.sorted
        detailView.title = self.sorted[indexPath.row].text
        self.navigationController?.pushViewController(detailView, animated: true)
    }

}
