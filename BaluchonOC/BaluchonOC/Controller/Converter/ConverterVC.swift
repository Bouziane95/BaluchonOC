//
//  ConverterVC.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import UIKit

class ConverterVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        convertBtn.isEnabled = false
        input.delegate = self
        input.keyboardType = .numberPad
    }
    
    var exchangeRates = [String]()
    
    let flagImg: [UIImage] = [UIImage(named: "australia")!, UIImage(named: "bulgaria")!, UIImage(named: "brazil")!, UIImage(named: "canada")!, UIImage(named: "switzerland")!, UIImage(named: "china")!, UIImage(named: "czech-republic")!, UIImage(named: "denmark")!, UIImage(named: "european-union")!, UIImage(named: "england")!, UIImage(named: "hong-kong")!, UIImage(named: "croatia")!, UIImage(named: "hungary")!, UIImage(named: "monaco")!, UIImage(named: "israel")!, UIImage(named: "india")!, UIImage(named: "iceland")!, UIImage(named: "japan")!, UIImage(named: "south-korea")!, UIImage(named: "mexico")!, UIImage(named: "malaysia")!, UIImage(named: "norway")!, UIImage(named: "new-zealand")!, UIImage(named: "philippines")!, UIImage(named: "republic-of-poland")!, UIImage(named: "romania")!, UIImage(named: "russia")!, UIImage(named: "sweden")!, UIImage(named: "singapore")!, UIImage(named: "thailand")!, UIImage(named: "turkey")!, UIImage(named: "united-states-of-america")!, UIImage(named: "south-africa")!]
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (input.text! as NSString).replacingCharacters(in: range, with: string)
        if Int(text) != nil {
            convertBtn.isEnabled = true
        } else {
            convertBtn.isEnabled = false
        }
        return true
    }
    
    @IBAction func convertBtnPressed(_ sender: Any) {
        exchangeRates.removeAll()
        ConverterAPI().getExchange {[weak self] (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    self?.exchangeRates.removeAll(keepingCapacity: false)
                    let currencies = response.rates.keys.sorted()
                    for currency in currencies{
                        guard let value = response.rates[currency] else {continue}
                        let inputValue = Double(self!.input.text!)
                        let resultValueRounded = NSString(format: "%.2f", (value * inputValue!))
                        
                        self?.exchangeRates.append("\(self!.input.text!) \(response.base) = \(resultValueRounded) \(currency)")
                    }
                    self?.tableView.reloadData()
                    
                case .failure: print("error")
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sectionNumber : Int = 1
        if exchangeRates.count > 0 {
            self.tableView.backgroundView = nil
            sectionNumber = 1
        } else {
            let noDataText : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.height))
            noDataText.text = "Enter an amount in $ and push the button to convert it !"
            noDataText.font = UIFont(name: "Marker Felt", size: 35)
            noDataText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            noDataText.textAlignment = .center
            noDataText.numberOfLines = 0
            self.tableView.backgroundView = noDataText
        }
        return sectionNumber
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rates", for: indexPath) as! ConverterCell
        cell.textLabel?.text = exchangeRates[indexPath.row]
        cell.flagImgCell.image = flagImg[indexPath.row]
        return cell
    }
    
    
}
