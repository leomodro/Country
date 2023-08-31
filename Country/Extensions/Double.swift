//
//  Double.swift
//  Country
//
//  Created by Leonardo Modro on 30/08/23.
//

import Foundation

extension Double {
    func countryAreaFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "Not available"
    }
}
