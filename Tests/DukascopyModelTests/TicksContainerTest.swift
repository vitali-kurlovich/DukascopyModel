//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 17.12.20.
//

@testable import DukascopyModel
import XCTest

final class TicksContainerTest: XCTestCase {
    func testSetDateRange_1() {
        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let ticks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let range = begin ..< end

        let container = TicksContainer(timeRange: range, ticks: ticks)

        XCTAssertEqual(container.ticks.count, 3)
    }

    func testSetDateRange_2() {
        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let ticks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let range = begin ..< end

        let container = TicksContainer(timeRange: range, ticks: ticks)

        XCTAssertEqual(container.ticks.count, 3)
    }

    func testSetDateRange_3() {
        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let ticks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_700_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_400_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let range = begin ..< end

        var container = TicksContainer(timeRange: range, ticks: ticks)

        XCTAssertEqual(container.ticks.count, 4)

        let destBegin = formatter.date(from: "04-04-2019 11:05")!
        let destEnd = formatter.date(from: "04-04-2019 11:30")!

        let destRange = destBegin ..< destEnd

        container.timeRange = destRange

        // XCTAssertEqual(container.ticks.count, 1)

        let destTicks: [Tick] = [
            .init(time: 1_600_000 - 5 * 60 * 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let destContainer = TicksContainer(timeRange: destRange, ticks: destTicks)
        XCTAssertEqual(container, destContainer)
    }

    func testTicksTimeRange() {
        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let ticks: [Tick] = [
            .init(time: 5 * 60 * 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_700_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_300_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let range = begin ..< end

        let container = TicksContainer(timeRange: range, ticks: ticks)

        let ticksTimeRange = formatter.date(from: "04-04-2019 11:05")! ..< formatter.date(from: "04-04-2019 11:55")!

        XCTAssertEqual(container.ticksTimeRange, ticksTimeRange)
    }

    static var allTests = [
        ("testSetDateRange_1", testSetDateRange_1),
        ("testSetDateRange_2", testSetDateRange_2),
        ("testSetDateRange_3", testSetDateRange_3),
    ]
}

private let utc = TimeZone(identifier: "UTC")!

private let calendar: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = utc
    return calendar
}()

private let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = calendar
    formatter.timeZone = utc
    formatter.dateFormat = "dd-MM-yyyy HH:mm"
    return formatter
}()
