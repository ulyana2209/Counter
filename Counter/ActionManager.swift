//
//  ActionHistory.swift
//  Counter
//
//  Created by user on 23.02.2026.
//

import Combine
import Foundation

final class ActionManager {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    @Published var actionHistory: Data {
        didSet {
            UserDefaults.standard.set(actionHistory, forKey: Keys.actionHistory)
        }
    }
    
    init() {
        self.actionHistory = UserDefaults.standard.data(forKey: "actionHistory") ?? Data()
    }
    
    func getHistory() -> ActionHistory {
        do {
            let actions = try decoder.decode(ActionHistory.self, from: actionHistory)
            print("current actions: \(actions)")
            return actions
        } catch {
            print("Failed to decode json")
        }
        return ActionHistory(actions: [])
    }
    
    func createHistory(actionType: ActionType) {
        let action = Action(action: actionType.description())
        do {
            var actionHistory = getHistory()
            actionHistory.actions.append(action)
            let json = try encoder.encode(actionHistory)
            self.actionHistory = json
            print("Successfully created action!!!")
        } catch {
            print("Failed to encode to json")
        }
    }
    
}

private enum Keys {
    static let actionHistory = "actionHistory"
}
