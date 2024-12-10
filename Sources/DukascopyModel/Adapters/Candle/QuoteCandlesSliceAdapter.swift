//
//  QuoteCandlesSliceAdapter.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

import Foundation

public struct QuoteCandlesSliceAdapter<CandleData: QuoteCandleProtocol>: Hashable, Sendable {
    public let type: PriceType
    public let pipValue: Double
    public let slice: CandlesSlice

    public init(type: PriceType, pipValue: Double, slice: CandlesSlice) {
        self.type = type
        self.pipValue = pipValue
        self.slice = slice
    }
}

public
extension QuoteCandlesSliceAdapter {
    init(type: PriceType, pipValue: Double, timeRange: DateInterval, candles: ArraySlice<Candle>) {
        let slice = CandlesSlice(timeRange: timeRange, candles: candles)
        self.init(type: type, pipValue: pipValue, slice: slice)
    }

    var timeRange: DateInterval { slice.timeRange }
    var candles: ArraySlice<Candle> { slice.candles }
}

extension QuoteCandlesSliceAdapter: RandomAccessCollection {
    public typealias Element = CandleData
    public typealias Index = CandlesSlice.Index
    public typealias Indices = CandlesSlice.Indices
    public typealias SubSequence = QuoteCandlesSliceAdapter<CandleData>

    public var startIndex: ArraySlice<Candle>.Index {
        slice.startIndex
    }

    public var endIndex: ArraySlice<Candle>.Index {
        slice.endIndex
    }

    public func index(before i: ArraySlice<Tick>.Index) -> ArraySlice<Tick>.Index {
        slice.index(before: i)
    }

    public func index(after i: ArraySlice<Tick>.Index) -> ArraySlice<Tick>.Index {
        slice.index(after: i)
    }

    public subscript(position: ArraySlice<Tick>.Index) -> CandleData {
        let candle = slice[position]
        let baseDate = timeRange.start
        return CandleData(candle, baseDate: baseDate, pipValue: pipValue, type: type)
    }

    public subscript(_ bounds: Range<Self.Index>) -> Self.SubSequence {
        .init(type: type, pipValue: pipValue, slice: slice[bounds])
    }
}
