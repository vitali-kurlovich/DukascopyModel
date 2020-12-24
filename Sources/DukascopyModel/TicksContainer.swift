//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 24.12.20.
//

import Foundation

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
extension TicksContainer {
    func equal(to container: TicksContainer) -> Bool {
        if self == container {
            return true
        }

        if ticks.count != container.ticks.count {
            return false
        }

        let delta = begin.timeIntervalSince(container.begin)
        let increment = Int32(round(delta * 1000))

        let sourceTicks = container.ticks.lazy.map { (tick) -> Tick in
            .init(time: tick.time - increment, askp: tick.askp, bidp: tick.bidp, askv: tick.askv, bidv: tick.bidv)
        }

        return ticks.elementsEqual(sourceTicks)
    }
}

public
extension TicksContainer {
    var dateRange: Range<Date>? {
        guard let first = ticks.first, let last = ticks.last else {
            return nil
        }

        let start = begin.addingTimeInterval(TimeInterval(first.time) / 1000)
        let end = begin.addingTimeInterval(TimeInterval(last.time) / 1000)

        return start ..< end
    }
}

public
extension TicksContainer {
    mutating
    func insert(container: TicksContainer) {
        guard let sourceRange = container.dateRange else {
            return
        }

        guard let range = dateRange else {
            insertToEnd(container: container)
            return
        }

        if range.upperBound < sourceRange.lowerBound {
            insertToEnd(container: container)
            return
        }

        if sourceRange.upperBound < range.lowerBound {
            insertToBegin(container: container)
            return
        }

        insertToMid(container: container)
    }
}

private
extension TicksContainer {
    mutating
    func insertToEnd(container: TicksContainer) {
        guard begin != container.begin else {
            ticks.append(contentsOf: container.ticks)
            return
        }

        let delta = begin.timeIntervalSince(container.begin)
        let increment = Int32(round(delta * 1000))

        let sourceTicks = container.ticks.lazy.map { (tick) -> Tick in
            .init(time: tick.time - increment, askp: tick.askp, bidp: tick.bidp, askv: tick.askv, bidv: tick.bidv)
        }

        ticks.append(contentsOf: sourceTicks)
    }

    mutating
    func insertToBegin(container: TicksContainer) {
        guard begin != container.begin else {
            ticks.insert(contentsOf: container.ticks, at: ticks.startIndex)
            return
        }

        let delta = begin.timeIntervalSince(container.begin)
        let increment = Int32(round(delta * 1000))

        let sourceTicks = container.ticks.lazy.map { (tick) -> Tick in
            .init(time: tick.time - increment, askp: tick.askp, bidp: tick.bidp, askv: tick.askv, bidv: tick.bidv)
        }

        ticks.insert(contentsOf: sourceTicks, at: ticks.startIndex)
    }

    mutating
    func insertToMidEqualBegin(container: TicksContainer) {
        assert(begin == container.begin)

        let srcTicks = container.ticks

        let srcFirst = srcTicks.first!

        let lowerIndex = ticks.lastIndex { (tick) -> Bool in
            tick.time < srcFirst.time
        }!

        let nextIndex = ticks.index(after: lowerIndex)

        let srcLast = srcTicks.last!
        let nextSrcTick = ticks[nextIndex]

        assert(srcLast.time < nextSrcTick.time)

        ticks.insert(contentsOf: srcTicks, at: nextIndex)
    }

    mutating
    func insertToMid(container: TicksContainer) {
        guard begin != container.begin else {
            insertToMidEqualBegin(container: container)
            return
        }

        let delta = begin.timeIntervalSince(container.begin)
        let increment = Int32(round(delta * 1000))

        let srcTicks = container.ticks.lazy.map { (tick) -> Tick in
            .init(time: tick.time - increment, askp: tick.askp, bidp: tick.bidp, askv: tick.askv, bidv: tick.bidv)
        }

        let srcFirst = srcTicks.first!

        let lowerIndex = ticks.lastIndex { (tick) -> Bool in
            tick.time < srcFirst.time
        }!

        let nextIndex = ticks.index(after: lowerIndex)

        let srcLast = srcTicks.last!
        let nextSrcTick = ticks[nextIndex]

        assert(srcLast.time < nextSrcTick.time)

        ticks.insert(contentsOf: srcTicks, at: nextIndex)
    }
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
