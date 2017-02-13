//
//  ViewController.swift
//  BeyondWunder
//
//  Created by hoemoon on 13/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListViewController: UITableViewController {
    let realm = try! Realm()
    let results = try! Realm().objects(TaskList.self)
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        self.notificationToken = results.addNotificationBlock { (changes: RealmCollectionChange) in
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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.title = "TASK LISTS"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    
    // Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = results[indexPath.row]
        cell.textLabel?.text = object.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realm.beginWrite()
            realm.delete(results[indexPath.row])
            try! realm.commitWrite()
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            let realm = self.realm
            realm.beginWrite()
            realm.delete(self.results[indexPath.row])
            try! realm.commitWrite()
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
                
                let realm = self.realm
                realm.beginWrite()
                let taskListId = self.results[indexPath.row].id
                realm.create(TaskList.self, value: ["id": taskListId, "text": text], update: true)
                print(self.results)
                try! realm.commitWrite()
            })
            self.present(alertController, animated: true, completion: nil)
        })
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = results[indexPath.row]
        let taskView = TaskViewController()
        taskView.taskListId = item.id
        taskView.taskListTitle = item.text
        taskView.realm = realm
        taskView.tasks = item.items
        
        self.navigationController?.pushViewController(taskView, animated: true)
        print(item)
    }
    
    
    // Actions
//    func backgroundAdd() {
//        DispatchQueue.global().async {
//            let realm = try! Realm()
//            realm.beginWrite()
//            realm.create(Task.self, value: ["text": TableViewController.randomString()])
//            try! realm.commitWrite()
//        }
//    }
    
    
    func add() {
        let alertController = UIAlertController(title: "New Task List", message: "Enter Task List Name", preferredStyle: .alert)
        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Task List Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertTextField.text , !text.isEmpty else { return }
            
            DispatchQueue.global().async {
                let realm = try! Realm()
                realm.beginWrite()
                realm.create(TaskList.self, value: ["text": text])
                try! realm.commitWrite()
            }
        })
        present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

