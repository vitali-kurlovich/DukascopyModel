//
//  CandlesContainer.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

import Foundation

public
struct CandlesContainer: Hashable, Sendable {
    var timeRange: DateInterval

    public
    private(set) var candles: [Candle]

    public init(timeRange: DateInterval, candles: [Candle]) {
        let upperTime = Int32(timeRange.duration * 1000)

        let ticksTimeRange = 0 ..< upperTime

        self.timeRange = timeRange
        self.candles = candles.filter { candle -> Bool in
            ticksTimeRange.contains(candle.time)
        }
    }
}

public
extension CandlesContainer {
    var ticksTimeRange: DateInterval? {
        guard let first = candles.first, let last = candles.last else {
            return nil
        }

        let start = timeRange.start.addingTimeInterval(TimeInterval(first.time) / 1000)
        let end = timeRange.start.addingTimeInterval(TimeInterval(last.time) / 1000)

        return DateInterval(start: start, end: end)
    }
}
