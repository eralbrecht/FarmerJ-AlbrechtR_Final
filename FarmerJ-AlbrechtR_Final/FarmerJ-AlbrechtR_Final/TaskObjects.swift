//
//  TaskObjects.swift
//  BackgroundTaskChanger
//
//  Created by cpsc on 11/9/20.
// this object saves all the tasks
// we will save the "task manager" object instead of tasks individually

import Foundation
import UIKit

struct TaskManager: Codable {
    static var taskCollection: [Task] = []
}
struct Task: Codable {
    var title: String = ""
    var date: Date
    var notes: String = ""    
}

