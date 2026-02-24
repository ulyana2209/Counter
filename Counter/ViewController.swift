//
//  ViewController.swift
//  Counter
//
//  Created by user on 18.02.2026.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var toCounter: UIButton!
    
    let actionManager = ActionManager()
    var counter: Int = 0
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounterLabel()
        loadHistory()
    }
    
   private func configureUI() {
       textView.textAlignment = .left
       counterLabel.text = "Значение счётчика: \(counter)"
       textView.isHidden = false
       resetButton.isHidden = true
    }
    
    private func loadHistory() {
        let history = actionManager.getHistory()
        var text = ""
        for action in history.actions {
            let formattedDate = Self.dateFormatter.string(from: action.date)
            text += "\(formattedDate) - \(action.action)\n"
        }
        textView.text = text
    }
    private func updateCounterLabel() {
        counterLabel.text = "Значение счётчика: \(counter)"
    }
    
    @IBAction func incrementTabbed(_ sender: Any) {
        counter += 1
        updateCounterLabel()
        actionManager.createHistory(actionType: .increase)
    }
    
    @IBAction func minusButtonDidTab(_ sender: Any) {
        guard counter > 0 else {
            actionManager.createHistory(actionType: .negativeValue)
            return
        }
        counter -= 1
        actionManager.createHistory(actionType: .decrease)
        updateCounterLabel()
    }
    
    @IBAction func resetButtonDidTab(_ sender: Any) {
        counter = 0
        updateCounterLabel()
        actionManager.createHistory(actionType: .reset)
    }
    
    @IBAction func toCounter(_ sender: UITapGestureRecognizer) {
        textView.isHidden = true
        resetButton.isHidden = false
        historyLabel.isHidden = true
        toCounter.isHidden = true
    }
}


