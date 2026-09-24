//
//  ViewController.swift
//  Counter
//
//  Created by Мария Макарова on 22.09.2026.
//

import UIKit

final class ViewController: UIViewController {
    private var counter: UInt = 0 {
        didSet {
            counterLabelView.text = "Значение счётчика: \(counter)"
        }
    }

    @IBOutlet weak var counterLabelView: UILabel!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var historyTextView: UITextView!

    @IBAction func buttonIncreaseTap(_ sender: UIButton) {
        counter += 1
        addTextToHistory(text: "значение изменено на +1")
    }

    @IBAction func buttonDecreaseTap(_ sender: UIButton) {
        if counter == 0 {
            addTextToHistory(text: "попытка уменьшить значение счётчика ниже 0")
        } else {
            counter -= 1
            addTextToHistory(text:"значение изменено на -1")
        }
    }
    
    @IBAction func buttonResetTap(_ sender: UIButton) {
        counter = 0
        addTextToHistory(text:"значение сброшено")
    }

    private func addTextToHistory(text: String) {
        let currentDate = Date().currentDateAsString()
        historyTextView.text.append("\n\n \(currentDate): \(text)")
    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    return storyboard.instantiateViewController(
        withIdentifier: "ViewController"
    )
}
