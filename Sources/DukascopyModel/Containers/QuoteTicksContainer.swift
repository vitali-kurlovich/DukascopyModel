//
//  QuoteTicksContainer.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 27.11.24.
//

import Foundation

public
struct QuoteTicksContainer: Hashable, Sendable {
    public var container: TicksContainer
    public let pipValue: Double

    public init(container: TicksContainer, pipValue: Double) {
        self.container = container
        self.pipValue = pipValue
    }
}

public
extension QuoteTicksContainer {
    var timeRange: Range<Date> {
        container.timeRange
    }

    var ticksTimeRange: Range<Date>? {
        container.ticksTimeRange
    }
}

extension QuoteTicksContainer: RandomAccessCollection {
    public typealias Element = QuotesTick

    public typealias Index = Array<Tick>.Index

    public typealias SubSequence = QuoteTicksSlice

    public typealias Indices = Array<Tick>.Indices

    public var startIndex: Index {
        container.ticks.startIndex
    }

    public var endIndex: Index {
        container.ticks.endIndex
    }

    public subscript(position: Index) -> QuotesTick {
        let tick = container.ticks[position]
        let baseDate = timeRange.lowerBound
        return QuotesTick(tick, baseDate: baseDate, pipValue: pipValue)
    }

    public subscript(bounds: Range<Self.Index>) -> Self.SubSequence {
        let ticks = container.ticks[bounds]
        return QuoteTicksSlice(pipValue: pipValue, timeRange: timeRange, ticks: ticks)
    }
}

public
extension QuoteTicksContainer {
    mutating
    func merge(container: TicksContainer) {
        self.container.merge(container: container)
    }

    mutating
    func merge(container: Self) {
        self.container.merge(container: container.container)
    }
}
