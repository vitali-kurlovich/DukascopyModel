//
//  Created by Vitali Kurlovich on 30.05.22.
//

import Foundation

public struct Group: Equatable {
    public let id: String
    public let title: String

    public let instruments: [Instrument]
    public let groups: [Group]

    public
    init(id: String,
         title: String,
         instruments: [Instrument] = [],
         groups: [Group] = [])
    {
        self.id = id
        self.title = title
        self.instruments = instruments
        self.groups = groups
    }
}

extension Group: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case instruments
        case groups
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        instruments = try container.decode([Instrument]?.self, forKey: .instruments) ?? []
        groups = try container.decode([Group]?.self, forKey: .groups) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)

        if !instruments.isEmpty {
            try container.encode(instruments, forKey: .instruments)
        }

        if !groups.isEmpty {
            try container.encode(groups, forKey: .groups)
        }
    }
}

extension Group: Sequence {
    public typealias Element = Instrument
    public typealias Iterator = GroupIterator

    public func makeIterator() -> GroupIterator {
        GroupIterator(self)
    }
}

public struct GroupIterator: IteratorProtocol {
    public typealias Element = Instrument

    var current: Array<Instrument>.Iterator?
    var iterator: Array<Array<Instrument>.Iterator>.Iterator
    public
    init(_ group: Group) {
        var iterators: [Array<Instrument>.Iterator] = []

        extractIterators(group: group, iterators: &iterators)

        iterator = iterators.makeIterator()
    }

    public mutating func next() -> Instrument? {
        guard let instruments = current?.next() else {
            current = iterator.next()
            return current?.next()
        }

        return instruments
    }
}

private
func extractIterators(group: Group, iterators: inout [Array<Instrument>.Iterator]) {
    if !group.instruments.isEmpty {
        iterators.append(group.instruments.makeIterator())
    }

    for subgroup in group.groups {
        extractIterators(group: subgroup, iterators: &iterators)
    }
}
