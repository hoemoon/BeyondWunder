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
    var taskText: String!
    var task: Task!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        task = realm.object(ofType: Task.self, forPrimaryKey: self.taskId)
        self.textLabel?.text = taskText
        self.imageView?.image = UIImage(named: "ic_check_circle")
        self.imageView?.frame = CGRect(x: 15, y: 11, width: 23, height: 22)
        if toggleCheck == true {
            self.imageView?.alpha = CGFloat(0.2)
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.taskText)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            self.textLabel?.attributedText = attributeString
        } else {
            self.imageView?.alpha = CGFloat(0.8)
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.taskText)
            self.textLabel?.attributedText = attributeString
            
        }
        self.imageView?.isUserInteractionEnabled = true
        self.imageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checked)))
        self.textLabel!.frame.origin.x = 50
    }
    
    func checked() {
        if toggleCheck == true {
            self.realm.beginWrite()
            task?.completed = false
            try! self.realm.commitWrite()
            
        } else {
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
