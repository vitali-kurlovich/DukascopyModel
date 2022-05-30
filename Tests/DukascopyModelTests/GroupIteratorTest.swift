//
//  GroupIteratorTest.swift
//
//
//  Created by Vitali Kurlovich on 30.05.22.
//

@testable import DukascopyModel
import XCTest

class GroupIteratorTest: XCTestCase {
    func testGroupsIterator() throws {
        let time = Date(timeIntervalSince1970: 3600.0 * 24 * 365 * 10)
        let histrory = InstrumentHistory(filename: "file", beginTick: time, begin10sec: time, beginMinute: time, beginHour: time, beginDay: time)

        let usdbyn = Instrument(symbol: "USDBYN",
                                meta: .init(title: "USD/BYN",
                                            description: ""),
                                currency: .init(base: "USD", quote: "BYN"),
                                history: histrory, pipValue: 0.1)

        let usdcad = Instrument(symbol: "USDCAD",
                                meta: .init(title: "USD/CAD",
                                            description: ""),
                                currency: .init(base: "USD", quote: "CAD"),
                                history: histrory, pipValue: 0.1)

        let oil = Instrument(symbol: "OL",
                             meta: .init(title: "OIL",
                                         description: ""),
                             currency: .init(base: "USD", quote: "USD"),
                             history: histrory, pipValue: 10)

        let usdjpy = Instrument(symbol: "USDJPY",
                                meta: .init(title: "USD/JPY",
                                            description: ""),
                                currency: .init(base: "USD", quote: "JPY"),
                                history: histrory, pipValue: 1)

        let usdeur = Instrument(symbol: "USDEUR",
                                meta: .init(title: "USD/EUR",
                                            description: ""),
                                currency: .init(base: "USD", quote: "EUR"),
                                history: histrory, pipValue: 0.01)

        let emptySubGroup = Group(id: "G1", title: "Title", instruments: [usdbyn, usdcad], groups: [])

        XCTAssertEqual([Instrument](emptySubGroup), [usdbyn, usdcad])

        let group = Group(id: "G1", title: "Title",
                          instruments: [usdbyn, usdcad],
                          groups: [
                              Group(id: "G2", title: "G2", instruments: [oil, usdjpy]),
                              Group(id: "G4", title: "G4", instruments: [usdeur]),
                          ])

        XCTAssertEqual([Instrument](group), [usdbyn, usdcad, oil, usdjpy, usdeur])

        let recursiveGroup = Group(id: "G1", title: "Title",

                                   groups: [
                                       Group(id: "G2", title: "G2", instruments: [usdbyn, usdcad]),
                                       Group(id: "G2", title: "G2", instruments: [oil, usdjpy], groups: [
                                           Group(id: "G4", title: "G4", instruments: [usdeur]),
                                       ]),
                                   ])

        XCTAssertEqual([Instrument](recursiveGroup), [usdbyn, usdcad, oil, usdjpy, usdeur])

        let recursiveGroup_1 = Group(id: "G1", title: "Title",

                                     groups: [
                                         Group(id: "G2", title: "G2", instruments: [usdbyn, usdcad]),
                                         Group(id: "G2", title: "G2", instruments: [oil, usdjpy], groups: [
                                             Group(id: "G4", title: "G4", groups: [
                                                 Group(id: "G6", title: "G2", instruments: [usdeur]),
                                             ]),
                                         ]),
                                     ])

        XCTAssertEqual([Instrument](recursiveGroup_1), [usdbyn, usdcad, oil, usdjpy, usdeur])
    }
}
