//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 4/14/20.
//

import Foundation

public
struct Tick: Equatable {
    public let date: Date
    public let price: Price
    public let volume: Volume
    
    public init(date: Date, price: Price, volume: Volume) {
        self.date = date
        self.price = price
        self.volume = volume
    }
}


