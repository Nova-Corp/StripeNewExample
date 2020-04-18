//
//  ViewController.swift
//  StripeNewExample
//
//  Created by ADMIN on 06/02/20.
//  Copyright © 2020 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    
    var productsAndPrices = [
        Product(emoji: "👕", price: 2000, title: "Laboris", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👖", price: 4000, title: "Nisi", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👗", price: 3000, title: "Nostrud", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👞", price: 700, title: "Exercitation", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👟", price: 600, title: "Enim", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👠", price: 1000, title: "Laborum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👡", price: 2000, title: "Duis", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👢", price: 2500, title: "Pariatur", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👒", price: 800, title: "Exercitation", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "💄", price: 2000, title: "Consectetur", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "🎩", price: 5000, title: "Magna", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👛", price: 5500, title: "Anim", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👜", price: 6000, title: "Culpa", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "🕶", price: 2000, title: "Occaecat", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        Product(emoji: "👚", price: 2500, title: "Esse", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", incart: false),
        ]{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var barBtn = UIBarButtonItem()
    var itemCart = UIButton()
    var viewCartBtn = UIButton(type: .custom)
    var cartItems = [Product](){
        didSet{
            viewCartBtn.setImage(UIImage(named: "view_cart"), for: .normal)
            barBtn.addBadge(number: cartItems.count)
            barBtn = UIBarButtonItem(customView: viewCartBtn)
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
        setupTitleCartButton()
    }
    
    func setupTitleCartButton() {
        viewCartBtn.setImage(UIImage(named: "view_cart"), for: .normal)
        viewCartBtn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        viewCartBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewCartBtn.widthAnchor.constraint(equalToConstant: 34),
            viewCartBtn.heightAnchor.constraint(equalToConstant: 34)
        ])
        barBtn = UIBarButtonItem(customView: viewCartBtn)
        navigationItem.rightBarButtonItems = [barBtn]
        
        viewCartBtn.addTarget(self, action: #selector(getCartDetails), for: .touchUpInside)
    }
    
    @objc func getCartDetails() {
        if cartItems.count != 0 {
            let vc = CheckoutViewController()
            vc.cartDetailsDelegate = self
            vc.cartItems = cartItems
            vc.productsAndPrices = productsAndPrices
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsAndPrices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        cell.productImage.image = emojiToImage(text: productsAndPrices[indexPath.row].emoji, size: 150)
        cell.productTitle.text = productsAndPrices[indexPath.row].title
        cell.productPrice.text = "Rs."+String(productsAndPrices[indexPath.row].price/100)
        cell.productDescription.text = productsAndPrices[indexPath.row].description
        cell.addToCart.setImage(UIImage(named: "shopping-cart-green"), for: .normal)
        cell.addToCart.tag = indexPath.row
        cell.addToCart.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        if productsAndPrices[indexPath.row].incart {
            cell.addToCart.setImage(UIImage(named: "shopping-cart-gold"), for: .normal)
        }else{
            cell.addToCart.setImage(UIImage(named: "shopping-cart-green"), for: .normal)
        }
        return cell
    }
    
    @objc func addToCart(_ button: UIButton) {
        if cartItems.filter({ el in el == productsAndPrices[button.tag] }).count > 0 {
            if productsAndPrices[button.tag].incart {
                productsAndPrices[button.tag].incart = false
                let pets = productsAndPrices.filter { cartItems.contains($0) }
                cartItems = pets
            }
        }else{
            productsAndPrices[button.tag].incart = true
            cartItems.append(productsAndPrices[button.tag])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
extension ViewController: CartDetailsDelegate {
    func didSendCartDetails(productsAndPrices: [Product], cartDetails: [Product]) {
        self.cartItems = cartDetails
        self.productsAndPrices = productsAndPrices
        print(productsAndPrices)
    }
}
