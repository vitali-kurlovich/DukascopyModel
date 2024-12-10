//
//  TicksContainerMergeTest.swift
//
//
//  Created by Vitali Kurlovich on 24.12.20.
//

@testable import DukascopyModel
import XCTest

final class TicksContainerMergeTest: XCTestCase {
    func testMergeToBegin_1() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = formatter.date(from: "04-04-2019 10:00")!
        let srcEnd = formatter.date(from: "04-04-2019 11:00")!

        let srcRange = DateInterval(start: srcBegin, end: srcEnd)

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 1000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqRange = DateInterval(start: formatter.date(from: "04-04-2019 10:00")!,
                                   end: formatter.date(from: "04-04-2019 12:00")!)

        let eqContainer = TicksContainer(timeRange: eqRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMergeToBegin_2() {
        let ticks: [Tick] = [
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_100_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_100_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMergeToEnd_1() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        let container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = formatter.date(from: "04-04-2019 10:00")!
        let srcEnd = formatter.date(from: "04-04-2019 11:00")!

        let srcRange = DateInterval(start: srcBegin, end: srcEnd)

        var srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        srcContainer.merge(container: container)

        let eqTicks: [Tick] = [
            .init(time: 0, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 1000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000 + 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqRange = DateInterval(start: formatter.date(from: "04-04-2019 10:00")!,
                                   end: formatter.date(from: "04-04-2019 12:00")!)

        let eqContainer = TicksContainer(timeRange: eqRange, ticks: eqTicks)

        XCTAssertEqual(srcContainer.ticks, eqContainer.ticks)

        XCTAssertEqual(srcContainer, eqContainer)
    }

    func testMergeToEnd_2() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 2_900_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 2_900_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMergeToEnd_3() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = []

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMergeToEnd_4() {
        let ticks: [Tick] = []

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMergeToMid_1() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 1_900_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_100_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_500_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_700_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

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

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMergeToMid_2() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 7_200_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 7_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 10:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 4_000_000 - 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 4_200_000 - 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 5_000_000 - 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcBegin = formatter.date(from: "04-04-2019 11:00")!
        let srcEnd = formatter.date(from: "04-04-2019 12:00")!

        let srcRange = DateInterval(start: srcBegin, end: srcEnd)

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

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

        let eqContainer = TicksContainer(timeRange: range, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMerge_1() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 1000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMerge_2() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 1_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMerge_3() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 2_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 4_600_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 3_600_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 4_600_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMerge_4() {
        let ticks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_400_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 1_900_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_100_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_500_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_900_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_900_000, askp: 2, bidp: 1, askv: 1, bidv: 1),

            .init(time: 2_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_100_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_400_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_500_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 2_900_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }

    func testMerge_5() {
        let ticks: [Tick] = [
            .init(time: 1_900_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_100_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_500_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_900_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
        ]

        let begin = formatter.date(from: "04-04-2019 11:00")!
        let end = formatter.date(from: "04-04-2019 12:00")!

        let range = DateInterval(start: begin, end: end)

        var container = TicksContainer(timeRange: range, ticks: ticks)

        let srcTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_400_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
        ]

        let srcRange = range

        let srcContainer = TicksContainer(timeRange: srcRange, ticks: srcTicks)

        container.merge(container: srcContainer)

        let eqTicks: [Tick] = [
            .init(time: 1000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 1_900_000, askp: 2, bidp: 1, askv: 1, bidv: 1),

            .init(time: 2_000_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_100_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_400_000, askp: 1, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_500_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
            .init(time: 2_800_000, askp: 1, bidp: 1, askv: 1, bidv: 1),

            .init(time: 2_900_000, askp: 2, bidp: 1, askv: 1, bidv: 1),
        ]

        let eqContainer = TicksContainer(timeRange: srcRange, ticks: eqTicks)

        XCTAssertEqual(container, eqContainer)
    }
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
