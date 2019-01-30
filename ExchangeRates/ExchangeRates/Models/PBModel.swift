//
//  PBModel.swift
//  ExchangeRates
//
//  Created by Илья on 1/27/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

    
struct PrivatModel: Decodable {
    var date: String?
    var bank: String?
    var baseCurrency: Int?
    var baseCurrencyLit: String?
    var exchangeRate: [ExchangeRate]

    struct ExchangeRate: Decodable {
        var baseCurrency: String?
        var currency: String?
        private var saleRateNB: Double?
        private var purchaseRateNB: Double?
        private var saleRate: Double?
        private var purchaseRate: Double?
        
        var purchaseRateString: String {
            return String(format: "%.2f", purchaseRate ?? purchaseRateNB ?? 0)
        }
        
        var salesRateString: String {
            return String(format: "%.2f", saleRate ?? saleRateNB ?? 0)
        }
    }
}

    




