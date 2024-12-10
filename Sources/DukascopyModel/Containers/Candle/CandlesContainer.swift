//
//  CandlesContainer.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

import Foundation

public
struct CandlesContainer: Hashable, Sendable {
    public private(set) var timeRange: DateInterval

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

extension CandlesContainer: RandomAccessCollection {
    public typealias Element = Candle
    public typealias Index = Array<Candle>.Index
    public typealias Indices = Array<Candle>.Indices
    public typealias SubSequence = CandlesSlice

    public var startIndex: Index {
        candles.startIndex
    }

    public var endIndex: Index {
        candles.endIndex
    }

    public func index(before i: Index) -> Index {
        candles.index(before: i)
    }

    public func index(after i: Index) -> Index {
        candles.index(after: i)
    }

    public subscript(position: Index) -> Candle {
        candles[position]
    }

    public subscript(_ range: Range<Self.Index>) -> Self.SubSequence {
        CandlesSlice(timeRange: timeRange, candles: candles[range])
    }
}
