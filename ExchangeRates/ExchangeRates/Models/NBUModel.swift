//
//  NBUModel.swift
//  ExchangeRates
//
//  Created by Илья on 1/27/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

struct NbuModel: Decodable {
    var r030: Int?
    var txt: String?
    var rate: Double?
    var cc: String?
    var exchangedate: String?
}


