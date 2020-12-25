//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 17.12.20.
//

@testable import DukascopyModel
import XCTest

final class TicksContainerTest: XCTestCase {
    func testSetDate() {
        let ticks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!

        var container = TicksContainer(begin: begin, ticks: ticks)

        let new = formatter.date(from: "04-04-2019 12:00")!

        container.begin = new

        XCTAssertEqual(container.ticks[0], .init(time: -3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1))
        XCTAssertEqual(container.ticks[1], .init(time: -3_599_999, askp: 1, bidp: 1, askv: 1, bidv: 1))

        XCTAssertEqual(container.ticks[2], .init(time: -3_599_998, askp: 1, bidp: 1, askv: 1, bidv: 1))
    }

    func testSetDate_1() {
        let ticks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!

        var container = TicksContainer(begin: begin, ticks: ticks)

        let new = formatter.date(from: "04-04-2019 11:00")!.addingTimeInterval(0.0001)

        container.begin = new

        XCTAssertEqual(container.ticks, ticks)
    }

    func testEqual() {
        let ticks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let new = formatter.date(from: "04-04-2019 12:00")!

        let srcContainer = TicksContainer(begin: begin, ticks: ticks)
        var dstContainer = srcContainer
        dstContainer.begin = new

        XCTAssertNotEqual(srcContainer, dstContainer)

        XCTAssertTrue(srcContainer.equal(to: dstContainer))

        let copy = srcContainer
        XCTAssertTrue(srcContainer.equal(to: copy))
    }

    func testEqual_1() {
        let ticks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!

        let srcTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcContainer = TicksContainer(begin: begin, ticks: ticks)
        let dstContainer = TicksContainer(begin: begin, ticks: srcTicks)

        XCTAssertNotEqual(srcContainer, dstContainer)
        XCTAssertFalse(srcContainer.equal(to: dstContainer))
    }

    func testDateRange() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let start = formatter.date(from: "04-04-2019 11:00")!.addingTimeInterval(1)
        let end = formatter.date(from: "04-04-2019 12:00")!

        let container = TicksContainer(begin: begin, ticks: ticks)

        XCTAssertEqual(start ..< end, container.dateRange)
    }

    func testInsertEmpty_1() {
        let srcBegin = formatter.date(from: "04-04-2019 10:00")!
        var emptyContainer = TicksContainer(begin: srcBegin, ticks: [])

        let destTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let destBegin = formatter.date(from: "04-04-2019 11:00")!

        let destContainer = TicksContainer(begin: destBegin, ticks: destTicks)

        emptyContainer.insert(container: destContainer)

        XCTAssertEqual(emptyContainer.begin, srcBegin)
        XCTAssertNotEqual(emptyContainer, destContainer)

        XCTAssertTrue(emptyContainer.equal(to: destContainer))
    }

    func testInsertEmpty_2() {
        let srcBegin = formatter.date(from: "04-04-2019 10:00")!
        let emptyContainer = TicksContainer(begin: srcBegin, ticks: [])

        let destTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let destBegin = formatter.date(from: "04-04-2019 11:00")!

        var destContainer = TicksContainer(begin: destBegin, ticks: destTicks)
        let copy = destContainer

        destContainer.insert(container: emptyContainer)

        XCTAssertEqual(copy, destContainer)
    }

    func testInsertToBegin_1() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!

        var container = TicksContainer(begin: begin, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = formatter.date(from: "04-04-2019 10:00")!

        let srcContainer = TicksContainer(begin: srcBegin, ticks: srcTicks)

        container.insert(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 1000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(begin: srcBegin, ticks: eqTicks)

        XCTAssertEqual(container.begin, begin)

        XCTAssertTrue(container.equal(to: eqContainer))
    }

    func testInsertToBegin_2() {
        let ticks: [Tick] = [
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!

        var container = TicksContainer(begin: begin, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_100_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = begin

        let srcContainer = TicksContainer(begin: srcBegin, ticks: srcTicks)

        container.insert(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_100_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(begin: srcBegin, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testInsertToEnd_1() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!

        let container = TicksContainer(begin: begin, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = formatter.date(from: "04-04-2019 10:00")!

        var srcContainer = TicksContainer(begin: srcBegin, ticks: srcTicks)

        srcContainer.insert(container: container)

        let eqTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 1000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(begin: srcBegin, ticks: eqTicks)

        XCTAssertEqual(srcContainer.begin, srcBegin)

        XCTAssertEqual(srcContainer, eqContainer)
    }

    func testInsertToEnd_2() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!

        var container = TicksContainer(begin: begin, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 2_900_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = begin

        let srcContainer = TicksContainer(begin: srcBegin, ticks: srcTicks)

        container.insert(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 2_900_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(begin: srcBegin, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testInsertToMid_1() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!

        var container = TicksContainer(begin: begin, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 1_900_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_100_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_500_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_700_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = begin

        let srcContainer = TicksContainer(begin: srcBegin, ticks: srcTicks)

        container.insert(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 1_900_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_100_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_500_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_700_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(begin: srcBegin, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testInsertToMid_2() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 7_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 7_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 10:00")!

        var container = TicksContainer(begin: begin, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 4_000_000 - 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 4_200_000 - 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 5_000_000 - 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = formatter.date(from: "04-04-2019 11:00")!

        let srcContainer = TicksContainer(begin: srcBegin, ticks: srcTicks)

        container.insert(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 4_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 4_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 5_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 7_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 7_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(begin: begin, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    static var allTests = [
        ("testSetDate", testSetDate),
        ("testSetDate_1", testSetDate_1),

        ("testEqual", testEqual),
        ("testEqual_1", testEqual_1),

        ("testDateRange", testDateRange),

        ("testInsertEmpty_1", testInsertEmpty_1),
        ("testInsertEmpty_2", testInsertEmpty_2),

        ("testInsertToBegin_1", testInsertToBegin_1),
        ("testInsertToBegin_2", testInsertToBegin_2),

        ("testInsertToEnd_1", testInsertToEnd_1),
        ("testInsertToEnd_2", testInsertToEnd_2),

        ("testInsertToMid_1", testInsertToMid_1),
        ("testInsertToMid_2", testInsertToMid_2),
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
