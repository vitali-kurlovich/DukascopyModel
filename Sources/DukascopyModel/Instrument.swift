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

extension Instrument: Codable {
    enum CodingKeys: String, CodingKey {
        case symbol = "sym"
        case meta
        case currency = "curr"
        case history = "hist"
        case pipValue = "pip"
        case commoditiesPerContract = "percontract"
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

extension InstrumentMeta: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case description = "desc"
        case tags
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        tags = try container.decode([String]?.self, forKey: .tags) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(title, forKey: .title)

        try container.encode(description, forKey: .description)

        if !tags.isEmpty {
            try container.encode(tags, forKey: .tags)
        }
    }
}

public struct InstrumentHistory: Equatable {
    public let filename: String
    public let beginTick: Date
    public let begin10sec: Date
    public let beginMinute: Date
    public let beginHour: Date

    public
    init(
        filename: String,
        beginTick: Date,
        begin10sec: Date,
        beginMinute: Date,
        beginHour: Date
    ) {
        self.filename = filename
        self.beginTick = beginTick
        self.begin10sec = begin10sec
        self.beginMinute = beginMinute
        self.beginHour = beginHour
    }
}

extension InstrumentHistory: Codable {
    enum CodingKeys: String, CodingKey {
        case filename = "file"
        case beginTick = "tick"
        case begin10sec = "10s"
        case beginMinute = "1m"
        case beginHour = "1h"
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

extension InstrumentCurrency: Codable {}
