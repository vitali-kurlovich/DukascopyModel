//
//  QuoteTickProtocol.swift
//  DukascopyModel
//
//  Created by Vitali Kurlovich on 10.12.24.
//

import Foundation

public protocol QuoteTickProtocol {
    init(_ tick: Tick, baseDate: Date, pipValue: Double)
}
