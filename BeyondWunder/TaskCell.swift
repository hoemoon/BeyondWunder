//
//  TaskCell.swift
//  BeyondWunder
//
//  Created by hoemoon on 14/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit
import RealmSwift

class TaskCell: UITableViewCell {
    var checkButtonView: UIView!
    var toggleCheck: Bool!
    var realm: Realm!
    var tasks :Results<Task>!
    var taskId: String!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        imageView?.frame (0.0, 0.0, 320.0, 43.5)
        self.imageView?.image = UIImage(named: "ic_check_circle")
        self.imageView?.frame = CGRect(x: 15, y: 11, width: 23, height: 23)
        if toggleCheck == true {
            self.imageView?.alpha = CGFloat(1)
        } else {
            self.imageView?.alpha = CGFloat(0.5)
        }
        self.imageView?.isUserInteractionEnabled = true
        self.imageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checked)))
        self.textLabel!.frame.origin.x = 50
    }
    
    func checked() {
//        let destinationIndexPath: IndexPath
        let task = realm.object(ofType: Task.self, forPrimaryKey: self.taskId)
        print(toggleCheck)
        if toggleCheck == true {
            self.realm.beginWrite()
            task?.completed = false
//            let uncompletedCount = tasks.filter("completed = false").count
//            destinationIndexPath = IndexPath(row: uncompletedCount - 1, section: 0)
//            print(self.tag)
//            print(tasks.count)
//            tasks.move(from: self.tag, to: destinationIndexPath.row)
            try! self.realm.commitWrite()
            
        } else {
            self.realm.beginWrite()
            task?.completed = true
//            destinationIndexPath = IndexPath(row: tasks.count - 1, section: 0)
//            tasks.move(from: self.tag, to: destinationIndexPath.row)
            try! self.realm.commitWrite()
            
        }
        
        // done 하면 젤 밑으로, undone 하면 undone 들 제일 위로
        
//        self.realm.beginWrite()
//            if task.completed {
//                // move cell to bottom
//                destinationIndexPath = IndexPath(row: tasks.count - 1, section: 0)
//            } else {
//                // move cell just above the first completed item
//                let completedCount = tasks.filter("completed = true").count
//                destinationIndexPath = IndexPath(row: tasks.count - completedCount - 1, section: 0)
//            }
//        tasks.move(from: self.tag, to: destinationIndexPath.row)
//        try! self.realm.commitWrite()

        
    }
    
    required init(coder :NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
