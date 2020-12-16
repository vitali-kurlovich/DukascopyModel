//
//  File.swift
//  
//
//  Created by Vitali Kurlovich on 16.12.20.
//

import Foundation

struct Dukascopy {

}

extension Dukascopy {
    public
    struct Tick: Equatable {
        public let time: Int32
        public let askp: Int32
        public let bidp: Int32
        public let askv: Float32
        public let bidv: Float32

        public
        init(time: Int32, askp: Int32, bidp: Int32, askv: Float32, bidv: Float32) {
            self.time = time
            self.askp = askp
            self.bidp = bidp
            self.askv = askv
            self.bidv = bidv
        }
    }
}

extension Dukascopy {
    
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
}
