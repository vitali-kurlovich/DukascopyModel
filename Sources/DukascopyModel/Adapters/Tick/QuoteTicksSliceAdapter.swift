//
//  QuoteTicksSliceAdapter.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 27.11.24.
//

import Foundation

public struct QuoteTicksSliceAdapter<TickData: QuoteTickProtocol>: Hashable, Sendable {
    public let pipValue: Double
    public let slice: TicksSlice

    public init(pipValue: Double, slice: TicksSlice) {
        self.pipValue = pipValue
        self.slice = slice
    }
}

public extension QuoteTicksSliceAdapter {
    init(pipValue: Double, timeRange: DateInterval, ticks: ArraySlice<Tick>) {
        let slice = TicksSlice(timeRange: timeRange, ticks: ticks)
        self.init(pipValue: pipValue, slice: slice)
    }

    var timeRange: DateInterval { slice.timeRange }
    var ticks: ArraySlice<Tick> { slice.ticks }
}

extension QuoteTicksSliceAdapter: RandomAccessCollection {
    public typealias Element = TickData
    public typealias Index = ArraySlice<Tick>.Index
    public typealias Indices = ArraySlice<Tick>.Indices
    public typealias SubSequence = QuoteTicksSliceAdapter<TickData>

    public var startIndex: Index {
        slice.startIndex
    }

    public var endIndex: Index {
        slice.endIndex
    }

    public func index(before i: Index) -> Index {
        slice.index(before: i)
    }

    public func index(after i: Index) -> Index {
        slice.index(after: i)
    }

    public subscript(position: Index) -> Element {
        let tick = slice[position]
        let baseDate = timeRange.start
        return TickData(tick, baseDate: baseDate, pipValue: pipValue)
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        .init(pipValue: pipValue, slice: slice[bounds])
    }
}
