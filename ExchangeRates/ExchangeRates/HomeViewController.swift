//
//  ViewController.swift
//  ExchangeRates
//
//  Created by Илья on 1/27/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private let PrivatURL = "https://api.privatbank.ua/p24api/exchange_rates?json&date="
    
    @IBOutlet var dateLabelNbu: UILabel!
    @IBOutlet var dateLabelPriv: UILabel!
    @IBOutlet var privateTable: UITableView!
    
    private var currencies: [PrivatModel.ExchangeRate] = []
    private var currencyViewController: NBUViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: Date())
        
        dateLabelPriv.text = dateString
        dateLabelNbu.text = dateString
        
        
        guard let url = URL(string: PrivatURL + dateString) else {
            fatalError("cant create URL")
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let privatDecode = try JSONDecoder().decode(PrivatModel.self, from: data)
                self.currencies = privatDecode.exchangeRate
            
                DispatchQueue.main.async {
                    self.privateTable.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        
        
    }
    @IBAction func pbButton(_ sender: Any) {
        self.alert(title: "Не реализовано!", message: "Здесь должен открываться Date Picker, но я его пока не смог реализовать:(", style: .alert)
    }
    @IBAction func nbButton(_ sender: Any) {
         self.alert(title: "Не реализовано!", message: "Здесь должен открываться Date Picker, но я его пока не смог реализовать:(", style: .alert)
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currency", let controller = segue.destination as? NBUViewController{
            currencyViewController = controller
            currencyViewController?.delegate = self
        }
    }
   
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        cell.configure(with: currencies[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currencyViewController?.select(currency: currencies[indexPath.row])
    }
}

extension HomeViewController: CurrencyTableViewControllerDelegate {
    func currencyControllerDidSelect(currency: NbuModel) {
        for (index, element) in currencies.enumerated() {
            if element.currency == currency.cc {                
                privateTable.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .middle)
            }
        }
    }
}
