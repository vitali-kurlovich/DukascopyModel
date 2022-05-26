//
//  Created by Vitali Kurlovich on 27.05.22.
//

import Foundation


public struct Instrument: Equatable {
    public let symbol: String
    public let meta: InstrumentMeta
    public let currency: InstrumentCurrency
    public let history: InstrumentHistory

    public let pipValue: Double
    public let commoditiesPerContract: Int?
}

public struct InstrumentMeta: Equatable {
    public let title: String
    public let description: String
    public let tags: [String]
}

public struct InstrumentHistory: Equatable {
    public let filename: String
    public let beginTick: Date
    public let begin10sec: Date
    public let beginMinute: Date
    public let beginHour: Date
    public let beginDay: Date
}

public struct InstrumentCurrency: Equatable {
    public let base: String
    public let quote: String
}

public struct Group: Equatable {
    public let id: String
    public let title: String

    public let instruments: [Instrument]

    public let groups: [Group]
}
