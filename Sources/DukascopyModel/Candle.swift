//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 16.12.20.
//

import Foundation

public
struct Candle: Equatable {
    public
    struct Price: Equatable {
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

    public let time: Int32
    public let price: Price
    public let volume: Float32

    public
    init(time: Int32, price: Price, volume: Float32) {
        self.time = time
        self.price = price
        self.volume = volume
    }
}
