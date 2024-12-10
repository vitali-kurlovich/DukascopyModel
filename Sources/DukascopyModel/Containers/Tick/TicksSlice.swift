//
//  TicksSlice.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 9.12.24.
//

import Foundation

public struct TicksSlice: Hashable, Sendable {
    public let timeRange: DateInterval
    public let ticks: ArraySlice<Tick>

    public init(timeRange: DateInterval, ticks: ArraySlice<Tick>) {
        self.timeRange = timeRange
        self.ticks = ticks
    }
}

extension TicksSlice: RandomAccessCollection {
    public typealias Element = Tick
    public typealias Index = ArraySlice<Tick>.Index
    public typealias Indices = ArraySlice<Tick>.Indices
    public typealias SubSequence = TicksSlice

    public var startIndex: Index {
        ticks.startIndex
    }

    public var endIndex: Index {
        ticks.endIndex
    }

    public func index(before i: Index) -> Index {
        ticks.index(before: i)
    }

    public func index(after i: Index) -> Index {
        ticks.index(after: i)
    }

    public subscript(position: Index) -> Element {
        ticks[position]
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        TicksSlice(timeRange: timeRange, ticks: ticks[bounds])
    }
}
