//
//  DecimalUtil.swift
//  bankley
//
//  Created by aldinugroho on 08/11/22.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
