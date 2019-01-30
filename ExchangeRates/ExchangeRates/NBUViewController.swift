//
//  NBUViewController.swift
//  ExchangeRates
//
//  Created by Илья on 1/27/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

protocol CurrencyTableViewControllerDelegate: class {
    func currencyControllerDidSelect(currency: NbuModel)
}


class NBUViewController: UITableViewController {
    private let NbuURL = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
    
    var nbuDecode: [NbuModel] = []
    weak var delegate: CurrencyTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: NbuURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                self.nbuDecode = try JSONDecoder().decode([NbuModel].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func select(currency: PrivatModel.ExchangeRate) {
        for (index, element) in nbuDecode.enumerated() {
            if element.cc == currency.currency {
                tableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .middle)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nbuDecode.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NBUCell
        let rate = NSString(format:"%.2f", nbuDecode[indexPath.row].rate!)
        cell.nbuFirst.text = nbuDecode[indexPath.row].txt
        cell.nbuSecond.text = nbuDecode[indexPath.row].cc
        cell.nbuThird.text = "\(rate) UAH"
        if cell.nbuSecond.text == "USD"{
            indexPath.row
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.currencyControllerDidSelect(currency: nbuDecode[indexPath.row])
    }
}
