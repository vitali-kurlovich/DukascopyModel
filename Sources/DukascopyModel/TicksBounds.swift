//
//  TicksBounds.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

public struct TicksBounds: Hashable, Sendable {
    public let timeRange: ClosedRange<Int32>
    public let askRange: ClosedRange<Int32>
    public let bidRange: ClosedRange<Int32>

    public init(timeRange: ClosedRange<Int32>, askRange: ClosedRange<Int32>, bidRange: ClosedRange<Int32>) {
        self.timeRange = timeRange
        self.askRange = askRange
        self.bidRange = bidRange
    }
}
