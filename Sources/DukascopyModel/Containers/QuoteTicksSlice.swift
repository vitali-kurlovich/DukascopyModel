//
//  QuoteTicksSlice.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 27.11.24.
//

import Foundation

public struct QuoteTicksSlice: Hashable, Sendable {
    public let pipValue: Double
    public let timeRange: Range<Date>

    public let ticks: ArraySlice<Tick>

    public init(pipValue: Double, timeRange: Range<Date>, ticks: ArraySlice<Tick>) {
        self.pipValue = pipValue
        self.timeRange = timeRange
        self.ticks = ticks
    }
}

extension QuoteTicksSlice: RandomAccessCollection {
    public typealias Element = QuotesTick
    public typealias Index = ArraySlice<Tick>.Index
    public typealias Indices = ArraySlice<Tick>.Indices
    public typealias SubSequence = QuoteTicksSlice

    public var startIndex: ArraySlice<Tick>.Index {
        ticks.startIndex
    }

    public var endIndex: ArraySlice<Tick>.Index {
        ticks.endIndex
    }

    public func index(before i: ArraySlice<Tick>.Index) -> ArraySlice<Tick>.Index {
        ticks.index(before: i)
    }

    public func index(after i: ArraySlice<Tick>.Index) -> ArraySlice<Tick>.Index {
        ticks.index(after: i)
    }

    public subscript(position: ArraySlice<Tick>.Index) -> QuotesTick {
        let tick = ticks[position]
        let baseDate = timeRange.lowerBound
        return QuotesTick(tick, baseDate: baseDate, pipValue: pipValue)
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        .init(pipValue: pipValue, timeRange: timeRange, ticks: ticks[bounds])
    }
}
