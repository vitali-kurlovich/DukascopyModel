//
//  CandlesSlice.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 9.12.24.
//

import Foundation

public struct CandlesSlice: Sendable, Hashable {
    public let timeRange: DateInterval
    public let candles: ArraySlice<Candle>

    public init(timeRange: DateInterval, candles: ArraySlice<Candle>) {
        self.timeRange = timeRange
        self.candles = candles
    }
}

extension CandlesSlice: RandomAccessCollection {
    public typealias Element = Candle
    public typealias Index = ArraySlice<Candle>.Index
    public typealias Indices = ArraySlice<Candle>.Indices
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

    public subscript(position: Index) -> Element {
        candles[position]
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        CandlesSlice(timeRange: timeRange, candles: candles[bounds])
    }
}
