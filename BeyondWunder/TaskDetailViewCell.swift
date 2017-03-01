//
//  TaskDetailViewCell.swift
//  BeyondWunder
//
//  Created by hoemoon on 20/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit

class TaskDetailViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        self.textLabel!.text = "task detail"
        super.layoutSubviews()
    }

}

class DueDateCell: TaskDetailViewCell {
    override func layoutSubviews() {
        self.textLabel!.text = "due date"
        super.layoutSubviews()
    }
}

class NoteCell: TaskDetailViewCell {
    override func layoutSubviews() {
        self.textLabel!.text = "note"
        super.layoutSubviews()
    }
}

class PhotoCell: TaskDetailViewCell {
    override func layoutSubviews() {
        self.textLabel!.text = "photo"
        super.layoutSubviews()
    }
}
