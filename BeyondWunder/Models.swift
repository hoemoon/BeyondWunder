//
//  Model.swift
//  BeyondWunder
//
//  Created by hoemoon on 13/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import Foundation
import RealmSwift

final class TaskListList: Object {
    dynamic var id = 0 // swiftlint:disable:this variable_name
    let items = List<TaskList>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class TaskList: Object {
    dynamic var id = NSUUID().uuidString // swiftlint:disable:this variable_name
    dynamic var text = ""
    dynamic var completed = false
    let items = List<Task>()
    
    var isCompletable: Bool {
        return !items.filter("completed == false").isEmpty
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Task: Object {
    dynamic var id = NSUUID().uuidString // swiftlint:disable:this variable_name
    dynamic var text = ""
    dynamic var completed = false
    
    var isCompletable: Bool { return true }
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
