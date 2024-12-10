//
//  QuoteCandlesAdapter.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

import Foundation

public
struct QuoteCandlesAdapter<CandleData: QuoteCandleProtocol>: Hashable, Sendable {
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
extension QuoteCandlesAdapter {
    var timeRange: DateInterval {
        container.timeRange
    }

    var ticksTimeRange: DateInterval? {
        container.ticksTimeRange
    }
}

extension QuoteCandlesAdapter: RandomAccessCollection {
    public typealias Element = CandleData
    public typealias Index = Array<Candle>.Index
    public typealias SubSequence = QuoteCandlesSliceAdapter<CandleData>
    public typealias Indices = Array<Candle>.Indices

    public var startIndex: Index {
        container.candles.startIndex
    }

    public var endIndex: Index {
        container.candles.endIndex
    }

    public subscript(position: Index) -> CandleData {
        let candle = container.candles[position]
        let baseDate = timeRange.start
        return CandleData(candle, baseDate: baseDate, pipValue: pipValue, type: type)
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        let candles = container.candles[bounds]
        return QuoteCandlesSliceAdapter(type: type, pipValue: pipValue, timeRange: timeRange, candles: candles)
    }
}
