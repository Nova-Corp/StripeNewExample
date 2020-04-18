//
//  PaymentGatewayViewController.swift
//  StripeNewExample
//
//  Created by ADMIN on 19/02/20.
//  Copyright © 2020 Success Resource Pte Ltd. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class PaymentGatewayViewController: UIViewController {
    let cardNumber = MDCTextField()
    let expMonth = MDCTextField()
    let expYear = MDCTextField()
    let cvc = MDCTextField()
    let email = MDCTextField()
    let name = MDCTextField()
    let address1 = MDCTextField()
    let postalCode = MDCTextField()
    let city = MDCTextField()
    let state = MDCTextField()
    let country = MDCTextField()
    let amount = MDCTextField()
    let currency = MDCTextField()
    let customerDescription = MDCMultilineTextField()
    let payBtn = UIButton(type: .custom)
    
    var TotalPrice = 0
    var priceType = ""
    
    let tokenUrl = "https://api.stripe.com/v1/tokens"
    let customerUrl = "https://api.stripe.com/v1/customers"
    let chargeUrl = "https://api.stripe.com/v1/charges"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        userInputViewSetup()
        payBtn.addTarget(self, action: #selector(makePayment), for: .touchUpInside)
    }
    
    @objc func makePayment() {
        let status = textFieldValidation()
        if !status.0{
            let alert = UIAlertController(title: "Warning", message: status.1, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Back", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        getLoader(msg: "Pleae Wait...")

        guard let number = Int(cardNumber.text ?? "0") else {return}
        guard let month = Int(expMonth.text ?? "0") else {return}
        guard let year = Int(expYear.text ?? "0") else {return}
        guard let cvcNum = Int(cvc.text ?? "0") else {return}
        
        let parametersForTok = "card%5Bnumber%5D=\(number)&card%5Bexp_month%5D=\(month)&card%5Bexp_year%5D=\(year)&card%5Bcvc%5D=\(cvcNum)"
        parseToken(parameter: parametersForTok){chargeResponse in
            guard let chargeId = chargeResponse[0].id else {
                let alert = UIAlertController(title: "Sorry", message: "Transaction Failed!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                return
            }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Success", message: "Dear Customer, Your Transaction is successful. Referance number is \(chargeId). Thank You!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    func getResponseFromStripe(parameter: String, url: String, completionHandler: @escaping( Data ) -> Void) {
    
        let postData =  parameter.data(using: .utf8)

        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic c2tfdGVzdF9NSDZnRWRnZU5sWWVVbm9EQmhIMERONVYwMEFvTWNaV25KOg==", forHTTPHeaderField: "Authorization")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            completionHandler(data)
        }
        task.resume()
    }
    
    func parseToken(parameter: String, completionHandler: @escaping( [ChargeResponse] ) -> Void) {
        let cusEmail = email.text
        let cusName = name.text
        let description = customerDescription.text
        let address = address1.text
        let zip = Int(postalCode.text!)
        let cusCity = city.text
        let cusState = state.text
        let cusCountry = country.text
        guard let amount = Int(amount.text ?? "0") else {return}
        guard let currencyType = currency.text else {return}
        getResponseFromStripe(parameter: parameter, url: tokenUrl){tokenResponse in
            do {
                let responseBody = try JSONDecoder().decode(TokenResponse.self, from: tokenResponse)
                guard let token = responseBody.id else {return}
                let parameterForCustomer = "source=\(token)&email=\(cusEmail)&name=\(cusName)&address%5Bline1%5D=\(address)&address%5Bpostal_code%5D=\(zip)&address%5Bcity%5D=\(cusCity)&address%5Bstate%5D=\(cusState)&address%5Bcountry%5D=\(cusCountry)"
                
                self.getResponseFromStripe(parameter: parameterForCustomer, url: self.customerUrl){customerReponse in
                    
                    do {
                        let responseBody = try JSONDecoder().decode(CustomerResponse.self, from: customerReponse)
                        guard let customerId = responseBody.id else {return}
                        let parameterForCharge = "amount=\(amount*100)&currency=\(currencyType)&customer=\(customerId)&description=\(description)"
                        self.getResponseFromStripe(parameter: parameterForCharge, url: self.chargeUrl){chargeResponse in
                            do {
                                let responseBody = try JSONDecoder().decode(ChargeResponse.self, from: chargeResponse)
                                completionHandler([responseBody])
                            } catch let error {
                                print(error)
                            }
                        }
                    } catch let error {
                        let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                        print(error.localizedDescription)
                    }
                }
            } catch let error{
                print(error)
            }
        }
    }
    
    func textFieldValidation() -> (Bool, String) {
        if cardNumber.text == "" {
            return (false, "Card Number Missing")
        } else if cardNumber.text == "" {
            return (false, "Card Number Missing")
        }else if expMonth.text == "" {
            return (false, "Expiry Month Missing")
        }else if cvc.text == "" {
            return (false, "CVC Missing")
        }else if email.text == "" {
            return (false, "Email Missing")
        }else if name.text == "" {
            return (false, "Name Missing")
        }else if address1.text == "" {
            return (false, "Address Missing")
        }else if postalCode.text == "" {
            return (false, "Postal Missing")
        }else if city.text == "" {
            return (false, "City Missing")
        }else if state.text == "" {
            return (false, "State Missing")
        }else if country.text == "" {
            return (false, "Country Missing")
        }else if amount.text == "" {
            return (false, "Amount Missing")
        }else if currency.text == "" {
            return (false, "Currency Missing")
        }else if customerDescription.text == "" {
            return (false, "Description Missing")
        }
        return (true, "Success!")
    }
}

extension PaymentGatewayViewController: UITextFieldDelegate, MDCMultilineTextInputDelegate {
    
    func getLoader(msg: String) {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setBackgroundLayerColor(UIColor.black.withAlphaComponent(0.5))
        SVProgressHUD.setBackgroundColor(.black)//Background Color
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: msg)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case cardNumber:
            guard let textFieldText = cardNumber.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 16
        case expMonth:
            guard let textFieldText = expMonth.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 2
        case expYear:
            guard let textFieldText = expYear.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 4
        case cvc:
            guard let textFieldText = cvc.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 3
        case postalCode:
            guard let textFieldText = postalCode.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 6
        default:
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 28
        }
    }
    
    func userInputViewSetup() {
        
        view.addSubview(cardNumber)
        cardNumber.delegate = self
        cardNumber.placeholderLabel.text = "Card Number"
        cardNumber.keyboardType = .numberPad
        cardNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardNumber.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            cardNumber.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            cardNumber.heightAnchor.constraint(equalToConstant: 34),
            
        ])
        
        view.addSubview(expMonth)
        expMonth.delegate = self
        expMonth.keyboardType = .numberPad
        expMonth.placeholderLabel.text = "Exp Month"
        expMonth.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expMonth.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            expMonth.leftAnchor.constraint(equalTo: cardNumber.rightAnchor, constant: 12),
            expMonth.heightAnchor.constraint(equalToConstant: 34),
            expMonth.widthAnchor.constraint(equalToConstant: 52),
        ])

        view.addSubview(expYear)
        expYear.delegate = self
        expYear.keyboardType = .numberPad
        expYear.placeholderLabel.text = "Year"
        expYear.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expYear.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            expYear.leftAnchor.constraint(equalTo: expMonth.rightAnchor, constant: 8),
            expYear.heightAnchor.constraint(equalToConstant: 34),
            expYear.widthAnchor.constraint(equalToConstant: 52),

        ])
        
        view.addSubview(cvc)
        cvc.delegate = self
        cvc.keyboardType = .numberPad
        cvc.placeholderLabel.text = "CVC"
        cvc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cvc.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            cvc.leftAnchor.constraint(equalTo: expYear.rightAnchor, constant: 12),
            cvc.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
            cvc.heightAnchor.constraint(equalToConstant: 34),
            cvc.widthAnchor.constraint(equalToConstant: 52),

        ])
        
        view.addSubview(name)
        name.delegate = self
        name.placeholderLabel.text = "Name"
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: cardNumber.bottomAnchor, constant: 12),
            name.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            name.heightAnchor.constraint(equalToConstant: 34),
        ])
        
        view.addSubview(email)
        email.delegate = self
        email.placeholderLabel.text = "Email"
        email.keyboardType = .emailAddress
        email.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: expMonth.bottomAnchor, constant: 12),
            email.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 12),
            email.heightAnchor.constraint(equalToConstant: 34),
            email.widthAnchor.constraint(equalTo: name.widthAnchor),
            email.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12)
        ])
        
        view.addSubview(customerDescription)
        customerDescription.multilineDelegate = self
        customerDescription.placeholderLabel.text = "Description"
        customerDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customerDescription.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 12),
            customerDescription.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            customerDescription.heightAnchor.constraint(equalToConstant: 128),
            customerDescription.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12)
        ])
        
        view.addSubview(address1)
        address1.delegate = self
        address1.placeholderLabel.text = "Address"
        address1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            address1.topAnchor.constraint(equalTo: customerDescription.bottomAnchor, constant: 12),
            address1.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            address1.heightAnchor.constraint(equalToConstant: 34),
            address1.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12)
        ])
        
        view.addSubview(city)
        city.delegate = self
        city.placeholderLabel.text = "City"
        city.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            city.topAnchor.constraint(equalTo: address1.bottomAnchor, constant: 12),
            city.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            city.heightAnchor.constraint(equalToConstant: 34),
        ])
        
        view.addSubview(state)
        state.delegate = self
        state.placeholderLabel.text = "State"
        state.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            state.topAnchor.constraint(equalTo: address1.bottomAnchor, constant: 12),
            state.leftAnchor.constraint(equalTo: city.rightAnchor, constant: 12),
            state.heightAnchor.constraint(equalToConstant: 34),
            state.widthAnchor.constraint(equalTo: city.widthAnchor),
            state.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12)
        ])
        
        view.addSubview(country)
        country.delegate = self
        country.placeholderLabel.text = "Country"
        country.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            country.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 12),
            country.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            country.heightAnchor.constraint(equalToConstant: 34),
        ])
        
        view.addSubview(postalCode)
        postalCode.delegate = self
        postalCode.keyboardType = .numberPad
        postalCode.placeholderLabel.text = "Zip Code"
        postalCode.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postalCode.topAnchor.constraint(equalTo: state.bottomAnchor, constant: 12),
            postalCode.leftAnchor.constraint(equalTo: country.rightAnchor, constant: 12),
            postalCode.heightAnchor.constraint(equalToConstant: 34),
            postalCode.widthAnchor.constraint(equalTo: country.widthAnchor),
            postalCode.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12)
        ])
        
        view.addSubview(amount)
        amount.delegate = self
        amount.keyboardType = .numberPad
        amount.placeholderLabel.text = "Amount"
        amount.isUserInteractionEnabled = false
        amount.text = String(TotalPrice/100)
        amount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amount.topAnchor.constraint(equalTo: country.bottomAnchor, constant: 12),
            amount.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            amount.heightAnchor.constraint(equalToConstant: 34),
        ])
        
        view.addSubview(currency)
        currency.delegate = self
        currency.placeholderLabel.text = "Currency"
        currency.isUserInteractionEnabled = false
        currency.text = priceType
        currency.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currency.topAnchor.constraint(equalTo: postalCode.bottomAnchor, constant: 12),
            currency.leftAnchor.constraint(equalTo: amount.rightAnchor, constant: 12),
            currency.heightAnchor.constraint(equalToConstant: 34),
            currency.widthAnchor.constraint(equalTo: amount.widthAnchor),
            currency.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12)
        ])
        
        view.addSubview(payBtn)
        payBtn.backgroundColor = UIColor(red:0.11, green:0.82, blue:0.63, alpha:1.0)
        payBtn.setTitle("Pay Now", for: .normal)
        payBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            payBtn.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: 28),
            payBtn.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            payBtn.heightAnchor.constraint(equalToConstant: 34),
            payBtn.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12)
        ])
    }
}
