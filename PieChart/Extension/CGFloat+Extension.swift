//
//  CGFloat+Extension.swift
//  PieChart
//
//  Created by Ken Phanith on 2018/05/23.
//  Copyright © 2018 Quad. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    /// Formats the CGFloat to a maximum of 1 decimal place.
    var formattedToOneDecimalPlace : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: self.native)) ?? "\(self)"
    }
}
