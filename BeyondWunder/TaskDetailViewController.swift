//
//  TaskDetailViewController.swift
//  BeyondWunder
//
//  Created by hoemoon on 13/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit
import RealmSwift

class TaskDetailViewController: UIViewController, UITextViewDelegate {
    var task:Task!
    var sorted: Results<Task>!
    var realm: Realm!
    var textField:UITextField!
    var textView:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        self.title = task.text
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
        //Text Label
        let textLabel = UILabel()
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textLabel.text  = "TASK NAME"
        
        textField = UITextField()
        textField.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textField.text = task.text
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        
        let textLabel2 = UILabel()
        textLabel2.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel2.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textLabel2.text  = "NOTE"
        
        // ui text view
        textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5
        textView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        textView.text = task.note
        textView.font? = UIFont(name: (self.textView.font?.fontName)!, size: (self.textView.font?.pointSize)! + 5.0)!
        textView.delegate = self

        
        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.fill
        stackView.spacing   = 5.0
        
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(textLabel2)
        stackView.addArrangedSubview(textView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        textField.addTarget(self, action: #selector(TaskDetailViewController.enableSave), for: UIControlEvents.editingChanged)

    }
    func enableSave() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    func save() {
        self.realm.beginWrite()
        task.text = textField.text!
        task.note = textView.text!
        try! self.realm.commitWrite()
        self.navigationItem.rightBarButtonItem?.isEnabled = false

    }
    func textViewDidChange(_ textView: UITextView) {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
