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
        }
    }

    // MARK: - Constants
    let counterKey: String = "counterKey"
    private let logArrayKey: String = "savedLogMsgKey"
    private var logArray: [String] = []

    // MARK: - Enums
    enum Action: Int {
        case increment
        case reset
        case decrement
    }

    // MARK: - IBActions
    @IBAction private func didTapIncreaseButton(_ sender: UIButton) {
        updateCounter(action: .increment)
    }

    @IBAction private func didTapDecreaseButton(_ sender: UIButton) {
        guard counter > 0 else {
            addTextToHistory(
                text: "попытка уменьшить значение счётчика ниже 0"
            )
            return
        }
        updateCounter(action: .decrement)
    }
    
    @IBAction private func didTapResetButton(_ sender: UIButton) {
        updateCounter(action: .reset)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = UserDefaults.standard.integer(forKey: counterKey)

        logArray = UserDefaults.standard.stringArray(forKey: logArrayKey) ?? Array()
        historyTextView.text = logArray.joined(separator: "\n")
    }

    // MARK: - Private Methods
    private func addTextToHistory(text: String) {
        let currentDate = Date().currentDateAsString()
        let message = "\n\(currentDate): \(text)"

        historyTextView.text.append(message)
        logArray.append(message)
        UserDefaults.standard.set(logArray, forKey: logArrayKey)

        let bottom = NSRange(
            location: historyTextView.text.count - 1,
            length: 1
        )
        historyTextView.scrollRangeToVisible(bottom)
    }

    private func updateCounter(action: Action) {
        switch action {
        case .increment:
            counter += 1
            addTextToHistory(text: "значение изменено на +1")
        case .reset:
            counter = 0
            addTextToHistory(text: "значение сброшено")
        case .decrement:
            counter -= 1
            addTextToHistory(text: "значение изменено на -1")
        }

        UserDefaults.standard.set(counter, forKey: counterKey)

    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    return storyboard.instantiateViewController(
        withIdentifier: "ViewController"
    )
}

