//
//  QuoteTicksAdapter.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 27.11.24.
//

import Foundation

public
struct QuoteTicksAdapter<TickData: QuoteTickProtocol>: Hashable, Sendable {
    public var container: TicksContainer
    public let pipValue: Double

    public init(container: TicksContainer, pipValue: Double) {
        self.container = container
        self.pipValue = pipValue
    }
}

public
extension QuoteTicksAdapter {
    var timeRange: DateInterval {
        container.timeRange
    }

    var ticksTimeRange: DateInterval? {
        container.ticksTimeRange
    }
}

extension QuoteTicksAdapter: RandomAccessCollection {
    public typealias Element = TickData
    public typealias Index = Array<Tick>.Index
    public typealias Indices = Array<Tick>.Indices
    public typealias SubSequence = QuoteTicksSliceAdapter<TickData>

    public var startIndex: Index {
        container.ticks.startIndex
    }

    public var endIndex: Index {
        container.ticks.endIndex
    }

    public subscript(position: Index) -> TickData {
        let tick = container.ticks[position]
        let baseDate = timeRange.start
        return TickData(tick, baseDate: baseDate, pipValue: pipValue)
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        let ticks = container.ticks[bounds]
        return QuoteTicksSliceAdapter(pipValue: pipValue, timeRange: timeRange, ticks: ticks)
    }
}

public
extension QuoteTicksAdapter {
    mutating
    func merge(container: TicksContainer) {
        self.container.merge(container: container)
    }

    mutating
    func merge(container: Self) {
        self.container.merge(container: container.container)
    }
}
