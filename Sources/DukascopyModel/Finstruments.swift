//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 16.12.20.
//

import Foundation

public
struct Finstruments: Equatable {
    public let instruments: [String: Instrument]
    public let groups: [String: Group]
}

public
extension Finstruments {
    struct Group: Equatable {
        public let id: String
        public let title: String
        public let parents: String?
        public let instruments: [String]?
    }
}

public
extension Finstruments {
    struct Instrument: Equatable {
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
    }
}
