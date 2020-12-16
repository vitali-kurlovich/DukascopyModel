//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 16.12.20.
//

import Foundation

public
struct Finstruments: Codable {
    public
    struct Group: Codable {
        public let id: String
        public let title: String
        public let parents: String?
        public let instruments: [String]?
    }

    public
    struct Instrument: Codable {
        public let title: String
        public let special: Bool
        public let name: String
        public let description: String
        public let filename: String
        public let pipValue: Double
        public let baseCurrency: String
        public let quoteCurrency: String
        public let tags: [String]

        public let historyStartTick: Int
        public let historyStart10sec: Int
        public let historyStartMinute: Int
        public let historyStartHour: Int
        public let historyStartDay: Int

        public let commoditiesPerContract: Int?
        public let unit: String?

        enum CodingKeys: String, CodingKey {
            case title
            case special
            case name
            case description
            case filename = "historical_filename"
            case pipValue
            case baseCurrency = "base_currency"
            case quoteCurrency = "quote_currency"
            case tags = "tag_list"
            case historyStartTick = "history_start_tick"
            case historyStart10sec = "history_start_10sec"
            case historyStartMinute = "history_start_60sec"
            case historyStartHour = "history_start_60min"
            case historyStartDay = "history_start_day"
            case commoditiesPerContract = "commodities_per_contract"
            case unit
        }
    }

    public let instruments: [String: Instrument]
    public let groups: [String: Group]
}
