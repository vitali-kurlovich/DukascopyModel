//
//  QuotesPrice.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

public
struct QuotesPrice: Hashable, Sendable {
    public let type: PriceType
    public let open: Double
    public let close: Double
    public let low: Double
    public let high: Double

    public
    init(type: PriceType, open: Double, close: Double, low: Double, high: Double) {
        self.type = type
        self.open = open
        self.close = close
        self.low = low
        self.high = high
    }
}
