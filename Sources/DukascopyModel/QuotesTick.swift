//
//  QuotesTick.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 27.11.24.
//

import Foundation

public
struct QuotesTick: Hashable {
    public let time: Date
    public let ask: Double
    public let bid: Double
    public let askVolume: Double
    public let bidVolume: Double

    public init(time: Date, ask: Double, bid: Double, askVolume: Double, bidVolume: Double) {
        self.time = time
        self.ask = ask
        self.bid = bid
        self.askVolume = askVolume
        self.bidVolume = bidVolume
    }
}

public
extension QuotesTick {
    init(_ tick: Tick, baseDate: Date, pipValue: Double) {
        let time = baseDate.addingTimeInterval(TimeInterval(tick.time) / 1000)
        let ask = Double(tick.askp) * pipValue
        let bid = Double(tick.bidp) * pipValue

        let askVolume = Double(tick.askv) * 10000.0
        let bidVolume = Double(tick.bidv) * 10000.0

        self.init(time: time, ask: ask, bid: bid, askVolume: askVolume, bidVolume: bidVolume)
    }
}
