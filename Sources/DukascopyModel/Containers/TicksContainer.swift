//
//  Created by Vitali Kurlovich on 24.12.20.
//

import Foundation

public
struct TicksContainer: Hashable, Sendable {
    var timeRange: Range<Date> {
        didSet {
            set(old: oldValue, new: timeRange)
        }
    }

    public
    private(set) var ticks: [Tick]

    public init(timeRange: Range<Date>, ticks: [Tick]) {
        let upperTime = Int32(timeRange.upperBound.timeIntervalSince(timeRange.lowerBound) * 1000)

        let ticksTimeRange = 0 ..< upperTime

        self.timeRange = timeRange
        self.ticks = ticks.filter { tick -> Bool in
            ticksTimeRange.contains(tick.time)
        }
    }
}

public
extension TicksContainer {
    var ticksTimeRange: Range<Date>? {
        guard let first = ticks.first, let last = ticks.last else {
            return nil
        }

        let start = timeRange.lowerBound.addingTimeInterval(TimeInterval(first.time) / 1000)
        let end = timeRange.lowerBound.addingTimeInterval(TimeInterval(last.time) / 1000)

        return start ..< end
    }
}

public
extension TicksContainer {
    mutating
    func merge(container: TicksContainer) {
        mergeInMid(container: container)
    }
}

private
extension TicksContainer {
    mutating
    func mergeInMid<T: RandomAccessCollection>(srcTicks: T) where T.Element == Tick {
        var leftIndex = ticks.startIndex
        var rightIndex = srcTicks.startIndex

        var result: [Tick] = []
        result.reserveCapacity(ticks.underestimatedCount + srcTicks.underestimatedCount)

        while leftIndex != ticks.endIndex || rightIndex != srcTicks.endIndex {
            if leftIndex == ticks.endIndex {
                result.append(contentsOf: srcTicks[rightIndex ..< srcTicks.endIndex])
                break
            }

            if rightIndex == srcTicks.endIndex {
                result.append(contentsOf: ticks[leftIndex ..< ticks.endIndex])
                break
            }

            let left = ticks[leftIndex]
            let right = srcTicks[rightIndex]

            if left.time == right.time {
                result.append(right)
                leftIndex = ticks.index(after: leftIndex)
                rightIndex = srcTicks.index(after: rightIndex)
                continue
            }

            if left.time < right.time {
                result.append(left)
                leftIndex = ticks.index(after: leftIndex)
                continue
            } else {
                result.append(right)
                rightIndex = srcTicks.index(after: rightIndex)
                continue
            }
        }
        ticks = result
    }

    mutating
    func mergeInMid(container: TicksContainer) {
        let lowerBound = min(timeRange.lowerBound, container.timeRange.lowerBound)
        let upperBound = max(timeRange.upperBound, container.timeRange.upperBound)

        timeRange = lowerBound ..< upperBound

        let delta = timeRange.lowerBound.timeIntervalSince(container.timeRange.lowerBound)
        let increment = Int32(round(delta * 1000))

        let srcTicks = container.ticks.lazy.map { tick -> Tick in
            .init(time: tick.time - increment, askp: tick.askp, bidp: tick.bidp, askv: tick.askv, bidv: tick.bidv)
        }

        mergeInMid(srcTicks: srcTicks)
    }
}

private
extension TicksContainer {
    mutating
    func set(old: Range<Date>, new: Range<Date>) {
        guard old != new, !ticks.isEmpty else {
            return
        }

        let delta = new.lowerBound.timeIntervalSince(old.lowerBound)

        let increment = Int32(round(delta * 1000))

        let upperTime = Int32(round(new.upperBound.timeIntervalSince(new.lowerBound) * 1000))

        let range = 0 ..< upperTime

        ticks = ticks.compactMap { tick -> Tick? in
            let time = tick.time - increment
            guard range.contains(time) else {
                return nil
            }
            return .init(time: time, askp: tick.askp, bidp: tick.bidp, askv: tick.askv, bidv: tick.bidv)
        }
    }
}
