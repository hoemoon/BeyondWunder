//
//  ViewController.swift
//  BeyondWunder
//
//  Created by hoemoon on 07/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        label.text = "TASK LIST"
        view.addSubview(label)
        // Do any additional setup after loading the view, typically from a nib.
    }

}

