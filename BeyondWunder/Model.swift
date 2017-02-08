//
//  Model.swift
//  BeyondWunder
//
//  Created by hoemoon on 08/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import Foundation
import RealmSwift

final class TaskList: Object {
    dynamic var id = ""
    dynamic var title = ""
    dynamic var order = ""
    let items = List<Task>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Task: Object {
    dynamic var id = ""
    dynamic var title = ""
    dynamic var order = ""
    dynamic var completed = false
    dynamic var stared = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
