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

    static var allTests = [
        ("testSetDate", testSetDate),
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
