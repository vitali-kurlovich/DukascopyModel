//
//  Created by Vitali Kurlovich on 16.12.20.
//

public
struct Tick: Hashable, Sendable {
    public let time: Int32
    public let askp: Int32
    public let bidp: Int32
    public let askv: Float32
    public let bidv: Float32

    public
    init(time: Int32, askp: Int32, bidp: Int32, askv: Float32, bidv: Float32) {
        self.time = time
        self.askp = askp
        self.bidp = bidp
        self.askv = askv
        self.bidv = bidv
    }
}

extension Tick: Codable {
    enum CodingKeys: String, CodingKey {
        case time
        case askp = "ask"
        case bidp = "bid"
        case askv = "vol_ask"
        case bidv = "vol_bid"
    }
}

public
extension Sequence<Tick> {
    var bounds: TicksBounds? {
        var iterator = makeIterator()

        guard let first = iterator.next() else {
            return nil
        }

        let startTime = first.time
        var endTime = startTime

        var minAsk = first.askp
        var maxAsk = minAsk

        var minBid = first.bidp
        var maxBid = minBid

        while let tick = iterator.next() {
            endTime = tick.time

            minAsk = Swift.min(minAsk, tick.askp)
            maxAsk = Swift.max(maxAsk, tick.askp)

            minBid = Swift.min(minBid, tick.bidp)
            maxBid = Swift.max(maxBid, tick.bidp)
        }

        return TicksBounds(timeRange: startTime ... endTime, askRange: minAsk ... maxAsk, bidRange: minBid ... maxBid)
    }
}
