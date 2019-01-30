//
//  CurrencyCell.swift
//  ExchangeRates
//
//  Created by Илья on 1/27/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell{
    @IBOutlet var pbFirstLabel: UILabel!
    @IBOutlet var pbSecondLabel: UILabel!
    @IBOutlet var pbThirdLabel: UILabel!
    
    
    func configure(with model: PrivatModel.ExchangeRate) {
        pbFirstLabel.text = model.currency ?? model.baseCurrency
        pbSecondLabel.text = model.purchaseRateString
        pbThirdLabel.text = model.salesRateString
    }
}
