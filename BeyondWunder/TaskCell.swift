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
        let task = realm.object(ofType: Task.self, forPrimaryKey: self.taskId)
        if toggleCheck == true { // unchecked
            self.realm.beginWrite()
            task?.completed = false
            try! self.realm.commitWrite()
            
        } else { // checked
            self.realm.beginWrite()
            task?.completed = true
            try! self.realm.commitWrite()
        }
        
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
