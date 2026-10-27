//
//  ViewController.swift
//  Counter
//
//  Created by Мария Макарова on 22.09.2026.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var increaseButton: UIButton!
    @IBOutlet private weak var decreaseButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var historyTextView: UITextView!
    
    // MARK: - Properties
    private var counter = 0 {
        didSet {
            counterLabel.text = "Значение счётчика: \(counter)"
            print("Записали значение на didset: \(counter)")
        }
    }

    // MARK: - Constants
    let counterKey: String = "counterKey"
    private let savedDataMsgKey: String = "savedLogMsgKey"


    // MARK: - IBActions
    @IBAction private func didTapIncreaseButton(_ sender: UIButton) {
        counter += 1
        addTextToHistory(text: "значение изменено на +1")
        UserDefaults.standard.set(counter, forKey: counterKey)
        print("Записали значение +1: \(counter)")
    }

    @IBAction private func didTapDecreaseButton(_ sender: UIButton) {
        guard counter > 0 else {
            addTextToHistory(
                text: "попытка уменьшить значение счётчика ниже 0"
            )
            return
        }
        counter -= 1
        UserDefaults.standard.set(counter, forKey: counterKey)
        print("Записали значение -1: \(counter)")
        addTextToHistory(text: "значение изменено на -1")
    }
    
    @IBAction private func didTapResetButton(_ sender: UIButton) {
        counter = 0
        UserDefaults.standard.set(counter, forKey: counterKey)
        print("Записали значение: сбросить \(counter)")
        addTextToHistory(text: "значение сброшено")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = UserDefaults.standard.integer(forKey: counterKey)
        print("Загрузили значение счетчика \(counter)")

        let savedDataMsg = UserDefaults.standard.string(forKey: savedDataMsgKey)
        if let savedDataMsg {
            print(savedDataMsg)
        }
    }

    // MARK: - Private Methods
    private func addTextToHistory(text: String) {
        let currentDate = Date().currentDateAsString()
        let message = "\n\(currentDate): \(text)"

        historyTextView.text.append(message)
        UserDefaults.standard.set(message, forKey: savedDataMsgKey)

        let bottom = NSRange(
            location: historyTextView.text.count - 1,
            length: 1
        )
        historyTextView.scrollRangeToVisible(bottom)
    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    return storyboard.instantiateViewController(
        withIdentifier: "ViewController"
    )
}

