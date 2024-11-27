//
//  Created by Vitali Kurlovich on 16.12.20.
//

import Foundation

public
struct Candle: Hashable, Sendable {
    public let time: Int32
    public let price: Price
    public let volume: Float32

    public
    init(time: Int32, price: Price, volume: Float32) {
        self.time = time
        self.price = price
        self.volume = volume
    }
}
