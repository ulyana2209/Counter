//
//  ViewController.swift
//  Counter
//
//  Created by user on 18.02.2026.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var toCounter: UIButton!
    let dateFormatter = DateFormatter()
    
    let actionManager = ActionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = "Значение счётчика: \(counter)"
        textView.isHidden = false
        resetButton.isHidden = true
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let history = ActionManager().getHistory()
        for act in history.actions {
            textView.text = textView.text + "\n\(act.date) - \(act.action)\n"
        }
        
        textView.textAlignment = .left
        
    }

    
    var counter: Int = 0
    
    @IBAction func buttonDidTab(_ sender: Any) {
        counter += 1
        counterLabel.text = "Значение счётчика: \(counter)"
        let actionType = ActionType.increase
        actionManager.createHistory(actionType: actionType)
        
    }
    @IBAction func minusButtonDidTab(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            counterLabel.text = "Значение счётчика: \(counter)"
            let actionType = ActionType.decrease
            actionManager.createHistory(actionType: actionType)
        } else {
            let actionType = ActionType.negativeValue
            actionManager.createHistory(actionType: actionType)
        }
    }
    @IBAction func resetButtonDidTab(_ sender: Any) {
        counter = 0
        counterLabel.text = "Значение счётчика: \(counter)"
        let actionType = ActionType.reset
        actionManager.createHistory(actionType: actionType)

    }
    @IBAction func toCounter(_ sender: UITapGestureRecognizer) {
        textView.isHidden = true
        resetButton.isHidden = false
        historyLabel.isHidden = true
        toCounter.isHidden = true
       
    }
}

