//
//  DateFormatter.swift
//  Counter
//
//  Created by Мария Макарова on 24.09.2026.
//

import Foundation

extension Date {
    func currentDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter.string(from: self)
    }
}
