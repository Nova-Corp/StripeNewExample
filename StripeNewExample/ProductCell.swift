//
//  ProductCell.swift
//  StripeNewExample
//
//  Created by ADMIN on 06/02/20.
//  Copyright © 2020 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    let productImage = UIImageView()
    let productTitle = UILabel()
    let productPrice = UILabel()
    let productDescription = UILabel()
    let addToCart = UIButton(type: .custom)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProductUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProductUI() {
        self.addSubview(productImage)
        productImage.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            productImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            productImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            productImage.widthAnchor.constraint(equalToConstant: 130),
            productImage.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        self.addSubview(addToCart)
        addToCart.backgroundColor = .clear
//        addToCart.setImage(UIImage(named: "supermarket"), for: .normal)
        addToCart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToCart.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            addToCart.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            addToCart.widthAnchor.constraint(equalToConstant: 40),
            addToCart.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(productTitle)
        productTitle.backgroundColor = .clear
        productTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        productTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            productTitle.leftAnchor.constraint(equalTo: self.productImage.rightAnchor, constant: 12),
            productTitle.rightAnchor.constraint(equalTo: self.addToCart.leftAnchor, constant: -12),
            productTitle.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        self.addSubview(productPrice)
        productPrice.backgroundColor = .clear
        productPrice.textColor = .darkGray
        productPrice.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: self.productTitle.bottomAnchor, constant: 4),
            productPrice.leftAnchor.constraint(equalTo: self.productImage.rightAnchor, constant: 12),
            productPrice.rightAnchor.constraint(equalTo: self.addToCart.leftAnchor, constant: -12),
            productPrice.heightAnchor.constraint(equalToConstant: 18),
        ])
        
        self.addSubview(productDescription)
        productDescription.backgroundColor = .clear
        productDescription.numberOfLines = 0
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productDescription.topAnchor.constraint(equalTo: self.productPrice.bottomAnchor, constant: 4),
            productDescription.leftAnchor.constraint(equalTo: self.productImage.rightAnchor, constant: 12),
            productDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            productDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}
