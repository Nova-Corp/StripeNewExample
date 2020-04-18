//
//  CheckoutViewController.swift
//  StripeNewExample
//
//  Created by ADMIN on 18/02/20.
//  Copyright © 2020 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

protocol CartDetailsDelegate{
    func didSendCartDetails(productsAndPrices: [Product], cartDetails: [Product])
}

class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var cartDetailsDelegate: CartDetailsDelegate?
    let tableView = UITableView()
    let footerView = UIView()
    let proceedBtn = UIButton(type: .system)
    
    var productsAndPrices = [Product](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var barBtn = UIBarButtonItem()
    var itemCart = UIButton()
    var cartItems = [Product](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.delegate = self
        tableView.dataSource = self

        setupTableView()
        setupFooter()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            cartDetailsDelegate?.didSendCartDetails(productsAndPrices: productsAndPrices, cartDetails: cartItems)
        }
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func setupFooter() {
        view.addSubview(footerView)
        footerView.backgroundColor = .clear
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 48),
            footerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            footerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            footerView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        footerView.addSubview(proceedBtn)
        proceedBtn.setTitle("Proceed", for: .normal)
        proceedBtn.tintColor = .white
        proceedBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        proceedBtn.addTarget(self, action: #selector(proceedToCheckout), for: .touchUpInside)
        proceedBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            proceedBtn.topAnchor.constraint(equalTo: footerView.topAnchor),
            proceedBtn.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            proceedBtn.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -12),
            proceedBtn.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 12),
        ])
    }
    
    @objc func proceedToCheckout() {
        if cartItems.count != 0 {
            let vc = PaymentGatewayViewController()
            vc.TotalPrice = calculateTotal()
            vc.priceType = "INR"
            navigationController?.pushViewController(vc, animated: true)
        }else{
            return
        }
    }
    
    func calculateTotal() -> Int{
        var price = 0
        for item in cartItems{
            price+=item.price
        }
        return price
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        cell.productImage.image = emojiToImage(text: cartItems[indexPath.row].emoji, size: 150)
        cell.productTitle.text = cartItems[indexPath.row].title
        cell.productPrice.text = "Rs."+String(cartItems[indexPath.row].price/100)
        cell.productDescription.text = cartItems[indexPath.row].description
        cell.addToCart.setImage(UIImage(named: "cross"), for: .normal)
        cell.addToCart.tag = indexPath.row
        cell.addToCart.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        return cell
    }
    
    @objc func addToCart(_ button: UIButton) {
        cartItems = cartItems.filter { $0 != cartItems[button.tag]}
        productsAndPrices[button.tag].incart = false
    }

    func emojiToImage(text: String, size: CGFloat) -> UIImage {
        let outputImageSize = CGSize(width: size, height: size)
        let baseSize = text.boundingRect(with: CGSize(width: 2048, height: 2048),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: UIFont.systemFont(ofSize: size / 2)], context: nil).size
        let fontSize = outputImageSize.width / max(baseSize.width, baseSize.height) * (outputImageSize.width / 2)
        let font = UIFont.systemFont(ofSize: fontSize)
        let textSize = text.boundingRect(with: CGSize(width: outputImageSize.width, height: outputImageSize.height),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: font], context: nil).size

        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byClipping

        let attr: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font,
                                                   NSAttributedString.Key.paragraphStyle: style,
                                                   NSAttributedString.Key.backgroundColor: UIColor.clear]

        UIGraphicsBeginImageContextWithOptions(outputImageSize, false, 0)
        text.draw(in: CGRect(x: (size - textSize.width) / 2,
                             y: (size - textSize.height) / 2,
                             width: textSize.width,
                             height: textSize.height),
                  withAttributes: attr)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
