//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 16.12.20.
//

import Foundation

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

public
struct TicksContainer: Equatable {
    public let begin: Date
    public let ticks: [Tick]

    public init(begin: Date, ticks: [Tick]) {
        self.begin = begin
        self.ticks = ticks
    }
}
