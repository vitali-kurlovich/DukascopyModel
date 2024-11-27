//
//  Price.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 28.11.24.
//

public
struct Price: Hashable, Sendable {
    public let open: Int32
    public let close: Int32
    public let low: Int32
    public let high: Int32

    public
    init(open: Int32, close: Int32, low: Int32, high: Int32) {
        self.open = open
        self.close = close
        self.low = low
        self.high = high
    }
}
