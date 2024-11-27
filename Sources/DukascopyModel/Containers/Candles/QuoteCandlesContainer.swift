//
//  QuoteCandlesContainer.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

import Foundation

public
struct QuoteCandlesContainer: Hashable, Sendable {
    public var container: CandlesContainer
    public let pipValue: Double
    public let type: PriceType

    public init(container: CandlesContainer, pipValue: Double, type: PriceType) {
        self.container = container
        self.pipValue = pipValue
        self.type = type
    }
}

public
extension QuoteCandlesContainer {
    var timeRange: DateInterval {
        container.timeRange
    }

    var ticksTimeRange: DateInterval? {
        container.ticksTimeRange
    }
}

extension QuoteCandlesContainer: RandomAccessCollection {
    public typealias Element = QuotesCandle
    public typealias Index = Array<Candle>.Index
    public typealias SubSequence = QuoteCandlesSlice
    public typealias Indices = Array<Candle>.Indices

    public var startIndex: Index {
        container.candles.startIndex
    }

    public var endIndex: Index {
        container.candles.endIndex
    }

    public subscript(position: Index) -> QuotesCandle {
        let candle = container.candles[position]
        let baseDate = timeRange.start
        return QuotesCandle(candle, baseDate: baseDate, pipValue: pipValue, type: type)
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        let candles = container.candles[bounds]
        return QuoteCandlesSlice(type: type, pipValue: pipValue, timeRange: timeRange, candles: candles)
    }
}
