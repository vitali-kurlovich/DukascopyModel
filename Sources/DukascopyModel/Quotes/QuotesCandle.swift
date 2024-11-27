//
//  QuotesCandle.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

import Foundation

public
struct QuotesCandle: Hashable, Sendable {
    public let type: PriceType
    public let time: Date
    public let price: QuotesPrice
    public let volume: Double

    public init(type: PriceType, time: Date, price: QuotesPrice, volume: Double) {
        self.type = type
        self.time = time
        self.price = price
        self.volume = volume
    }
}

public
extension QuotesCandle {
    init(_ candle: Candle, baseDate: Date, pipValue: Double, type: PriceType) {
        let time = baseDate.addingTimeInterval(TimeInterval(candle.time) / 1000)

        let open = Double(candle.price.open) * pipValue
        let close = Double(candle.price.close) * pipValue

        let high = Double(candle.price.high) * pipValue
        let low = Double(candle.price.low) * pipValue

        let price = QuotesPrice(type: type, open: open, close: close, low: low, high: high)

        let volume = Double(candle.volume) * 10000.0

        self.init(type: type, time: time, price: price, volume: volume)
    }
}
