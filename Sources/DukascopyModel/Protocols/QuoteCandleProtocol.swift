//
//  QuoteCandleProtocol.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 10.12.24.
//

import Foundation

public protocol QuoteCandleProtocol {
    init(_ candle: Candle, baseDate: Date, pipValue: Double, type: PriceType)
}
