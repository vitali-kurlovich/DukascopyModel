//
//  QuoteCandlesSlice.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

import Foundation

public struct QuoteCandlesSlice: Hashable, Sendable {
    public let type: PriceType
    public let pipValue: Double
    public let timeRange: DateInterval

    public let candles: ArraySlice<Candle>

    public init(type: PriceType, pipValue: Double, timeRange: DateInterval, candles: ArraySlice<Candle>) {
        self.type = type
        self.pipValue = pipValue
        self.timeRange = timeRange
        self.candles = candles
    }
}

extension QuoteCandlesSlice: RandomAccessCollection {
    public typealias Element = QuotesCandle
    public typealias Index = ArraySlice<Candle>.Index
    public typealias Indices = ArraySlice<Candle>.Indices
    public typealias SubSequence = QuoteCandlesSlice

    public var startIndex: ArraySlice<Candle>.Index {
        candles.startIndex
    }

    public var endIndex: ArraySlice<Candle>.Index {
        candles.endIndex
    }

    public func index(before i: ArraySlice<Tick>.Index) -> ArraySlice<Tick>.Index {
        candles.index(before: i)
    }

    public func index(after i: ArraySlice<Tick>.Index) -> ArraySlice<Tick>.Index {
        candles.index(after: i)
    }

    public subscript(position: ArraySlice<Tick>.Index) -> QuotesCandle {
        let candle = candles[position]
        let baseDate = timeRange.start
        return QuotesCandle(candle, baseDate: baseDate, pipValue: pipValue, type: type)
    }

    public subscript(_: Range<Self.Index>) -> Self.SubSequence {
        .init(type: type, pipValue: pipValue, timeRange: timeRange, candles: candles)
    }
}
