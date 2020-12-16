//
//  Price.swift
//  Dukascopy
//
//  Created by Vitali Kurlovich on 4/20/20.
//

import Foundation

public
struct Price: Equatable {
    public let ask: Int32
    public let bid: Int32
    
    public init(ask: Int32, bid: Int32) {
        self.ask = ask
        self.bid = bid
    }
}
