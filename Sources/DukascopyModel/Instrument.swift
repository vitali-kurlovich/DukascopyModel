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

    public
    init(symbol: String,
         meta: InstrumentMeta,
         currency: InstrumentCurrency,
         history: InstrumentHistory,
         pipValue: Double,
         commoditiesPerContract: Int? = nil)
    {
        precondition(!symbol.isEmpty)

        self.symbol = symbol
        self.meta = meta
        self.currency = currency
        self.history = history
        self.pipValue = pipValue
        self.commoditiesPerContract = commoditiesPerContract
    }
}

public struct InstrumentMeta: Equatable {
    public let title: String
    public let description: String
    public let tags: [String]

    public
    init(title: String, description: String, tags: [String] = []) {
        self.title = title
        self.description = description
        self.tags = tags
    }
}

public struct InstrumentHistory: Equatable {
    public let filename: String
    public let beginTick: Date
    public let begin10sec: Date
    public let beginMinute: Date
    public let beginHour: Date
    public let beginDay: Date

    public
    init(
        filename: String,
        beginTick: Date,
        begin10sec: Date,
        beginMinute: Date,
        beginHour: Date,
        beginDay: Date
    ) {
        self.filename = filename
        self.beginTick = beginTick
        self.begin10sec = begin10sec
        self.beginMinute = beginMinute
        self.beginHour = beginHour
        self.beginDay = beginDay
    }
}

public struct InstrumentCurrency: Equatable {
    public let base: String
    public let quote: String

    public
    init(base: String, quote: String) {
        self.base = base
        self.quote = quote
    }
}
