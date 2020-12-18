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
    public var begin: Date {
        didSet {
            set(old: oldValue, new: begin)
        }
    }

    private(set) var ticks: [Tick]

    public init(begin: Date, ticks: [Tick]) {
        self.begin = begin
        self.ticks = ticks
    }
}

public
extension TicksContainer {}

public
extension TicksContainer {
    mutating
    func insert(_: TicksContainer) {}
}

private
extension TicksContainer {
    mutating
    func set(old: Date, new: Date) {
        let delta = new.timeIntervalSince(old)

        let increment = Int32(round(delta * 1000))

        guard increment != 0 else {
            return
        }

        for index in ticks.startIndex ..< ticks.endIndex {
            let oldTick = ticks[index]
            let time = oldTick.time - increment
            ticks[index] = Tick(time: time, askp: oldTick.askp, bidp: oldTick.bidp, askv: oldTick.askv, bidv: oldTick.bidv)
        }
    }
}
