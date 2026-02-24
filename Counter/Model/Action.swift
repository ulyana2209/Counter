//
//  Action.swift
//  Counter
//
//  Created by user on 23.02.2026.
//
import Foundation

struct ActionHistory: Codable {
    var actions: [Action]
}

struct Action: Codable {
    var date: Date
    var action: String
        
    init(action: String) {
        self.date = Date.now
        self.action = action
    }
    
    init(date: Date, action: String) {
        self.date = date
        self.action = action
    }
    
}

enum ActionType {
    case increase
    case decrease
    case reset
    case negativeValue
    
    func description() -> String {
        switch self {
        case .increase: return "Значение изменено на +1"
        case .decrease: return "Значение изменено на -1"
        case .reset: return "Значение сброшено"
        case .negativeValue: return "Попытка уменьшить значение счётчика ниже 0"
        }
    }
}
