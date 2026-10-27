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
    private let savedDataMsgArr: String = "savedLogMsgKey"
    private var logArray: [String] = []


    // MARK: - IBActions
    @IBAction private func didTapIncreaseButton(_ sender: UIButton) {
        manageCounter(action: .positive)
    }

    @IBAction private func didTapDecreaseButton(_ sender: UIButton) {
        guard counter > 0 else {
            addTextToHistory(
                text: "попытка уменьшить значение счётчика ниже 0"
            )
            return
        }
        manageCounter(action: .negative)
    }
    
    @IBAction private func didTapResetButton(_ sender: UIButton) {
        manageCounter(action: .zero)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = UserDefaults.standard.integer(forKey: counterKey)

        let log = UserDefaults.standard.stringArray(forKey: savedDataMsgArr)
        if let log {
            historyTextView.text = log.joined(separator: "\n")

        }
    }

    // MARK: - Private Methods
    private func addTextToHistory(text: String) {
        let currentDate = Date().currentDateAsString()
        let message = "\n\(currentDate): \(text)"

        historyTextView.text.append(message)
        logArray.append(message)
        UserDefaults.standard.set(logArray, forKey: savedDataMsgArr)

        let bottom = NSRange(
            location: historyTextView.text.count - 1,
            length: 1
        )
        historyTextView.scrollRangeToVisible(bottom)
    }

    enum Action: Int {
        case positive = 1
        case zero = 0
        case negative = -1
    }

    private func manageCounter(action: Action) {
        switch action {
        case .positive:
            counter += 1
            addTextToHistory(text: "значение изменено на +1")
            UserDefaults.standard.set(counter, forKey: counterKey)
        case .zero:
            counter = 0
            UserDefaults.standard.set(counter, forKey: counterKey)
            addTextToHistory(text: "значение сброшено")
        case .negative:
            counter -= 1
            UserDefaults.standard.set(counter, forKey: counterKey)
            addTextToHistory(text: "значение изменено на -1")
        }

    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    return storyboard.instantiateViewController(
        withIdentifier: "ViewController"
    )
}

