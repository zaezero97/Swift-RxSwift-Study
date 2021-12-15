//
//  Task.swift
//  GoodListApp
//
//  Created by 재영신 on 2021/12/15.
//

import Foundation

enum Priority: Int{
    case High
    case Medium
    case Low
}
struct Task {
    let title: String
    let priority: Priority
}
