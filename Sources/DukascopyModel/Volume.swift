//
//  Volume.swift
//  Dukascopy
//
//  Created by Vitali Kurlovich on 4/20/20.
//

import Foundation

public
struct Volume: Equatable {
    public let ask: Float32
    public let bid: Float32
    
    public init(ask: Float32, bid: Float32) {
        self.ask = ask
        self.bid = bid
    }
}


