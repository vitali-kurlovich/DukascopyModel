//
//  Candle.swift
//  Dukascopy
//
//  Created by Vitali Kurlovich on 4/20/20.
//

import Foundation

public
struct Candle: Equatable {
    public let period: Range<Date>
    public let open: Price
    public let close: Price
    public let high: Price
    public let low: Price
    public let volume: Volume
    
    public init(period: Range<Date>,
                open: Price, close: Price,
                high: Price, low: Price,
                volume: Volume) {
        self.period = period
        self.open = open
        self.close = close
        self.high = high
        self.low = low
        self.volume = volume
    }
}
