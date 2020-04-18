//
//  ProductModel.swift
//  StripeNewExample
//
//  Created by ADMIN on 19/02/20.
//  Copyright © 2020 Success Resource Pte Ltd. All rights reserved.
//

import Foundation

struct Product: Equatable {
    let emoji: String
    let price: Int
    let title: String
    let description: String
    var incart: Bool
}

// MARK: - ChargeResponse
struct ChargeResponse: Codable {
    let id, object: String?
    let amount, amountRefunded: Int?
    let application, applicationFee, applicationFeeAmount: JSONNull?
    let balanceTransaction: String?
    let billingDetails: BillingDetails?
    let captured: Bool?
    let created: Int?
    let currency, customer, chargeResponseDescription: String?
    let destination, dispute: JSONNull?
    let disputed: Bool?
    let failureCode, failureMessage: JSONNull?
    let fraudDetails: FraudDetails?
    let invoice: JSONNull?
    let livemode: Bool?
    let metadata: FraudDetails?
    let onBehalfOf, order: JSONNull?
    let outcome: Outcome?
    let paid: Bool?
    let paymentIntent: JSONNull?
    let paymentMethod: String?
    let paymentMethodDetails: PaymentMethodDetails?
    let receiptEmail, receiptNumber: JSONNull?
    let receiptURL: String?
    let refunded: Bool?
    let refunds: Refunds?
    let review, shipping: JSONNull?
    let source: Source?
    let sourceTransfer, statementDescriptor, statementDescriptorSuffix: JSONNull?
    let status: String?
    let transferData, transferGroup: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, object, amount
        case amountRefunded
        case application
        case applicationFee
        case applicationFeeAmount
        case balanceTransaction
        case billingDetails
        case captured, created, currency, customer
        case chargeResponseDescription
        case destination, dispute, disputed
        case failureCode
        case failureMessage
        case fraudDetails
        case invoice, livemode, metadata
        case onBehalfOf
        case order, outcome, paid
        case paymentIntent
        case paymentMethod
        case paymentMethodDetails
        case receiptEmail
        case receiptNumber
        case receiptURL
        case refunded, refunds, review, shipping, source
        case sourceTransfer
        case statementDescriptor
        case statementDescriptorSuffix
        case status
        case transferData
        case transferGroup
    }
}

// MARK: ChargeResponse convenience initializers and mutators

extension ChargeResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ChargeResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        object: String?? = nil,
        amount: Int?? = nil,
        amountRefunded: Int?? = nil,
        application: JSONNull?? = nil,
        applicationFee: JSONNull?? = nil,
        applicationFeeAmount: JSONNull?? = nil,
        balanceTransaction: String?? = nil,
        billingDetails: BillingDetails?? = nil,
        captured: Bool?? = nil,
        created: Int?? = nil,
        currency: String?? = nil,
        customer: String?? = nil,
        chargeResponseDescription: String?? = nil,
        destination: JSONNull?? = nil,
        dispute: JSONNull?? = nil,
        disputed: Bool?? = nil,
        failureCode: JSONNull?? = nil,
        failureMessage: JSONNull?? = nil,
        fraudDetails: FraudDetails?? = nil,
        invoice: JSONNull?? = nil,
        livemode: Bool?? = nil,
        metadata: FraudDetails?? = nil,
        onBehalfOf: JSONNull?? = nil,
        order: JSONNull?? = nil,
        outcome: Outcome?? = nil,
        paid: Bool?? = nil,
        paymentIntent: JSONNull?? = nil,
        paymentMethod: String?? = nil,
        paymentMethodDetails: PaymentMethodDetails?? = nil,
        receiptEmail: JSONNull?? = nil,
        receiptNumber: JSONNull?? = nil,
        receiptURL: String?? = nil,
        refunded: Bool?? = nil,
        refunds: Refunds?? = nil,
        review: JSONNull?? = nil,
        shipping: JSONNull?? = nil,
        source: Source?? = nil,
        sourceTransfer: JSONNull?? = nil,
        statementDescriptor: JSONNull?? = nil,
        statementDescriptorSuffix: JSONNull?? = nil,
        status: String?? = nil,
        transferData: JSONNull?? = nil,
        transferGroup: JSONNull?? = nil
    ) -> ChargeResponse {
        return ChargeResponse(
            id: id ?? self.id,
            object: object ?? self.object,
            amount: amount ?? self.amount,
            amountRefunded: amountRefunded ?? self.amountRefunded,
            application: application ?? self.application,
            applicationFee: applicationFee ?? self.applicationFee,
            applicationFeeAmount: applicationFeeAmount ?? self.applicationFeeAmount,
            balanceTransaction: balanceTransaction ?? self.balanceTransaction,
            billingDetails: billingDetails ?? self.billingDetails,
            captured: captured ?? self.captured,
            created: created ?? self.created,
            currency: currency ?? self.currency,
            customer: customer ?? self.customer,
            chargeResponseDescription: chargeResponseDescription ?? self.chargeResponseDescription,
            destination: destination ?? self.destination,
            dispute: dispute ?? self.dispute,
            disputed: disputed ?? self.disputed,
            failureCode: failureCode ?? self.failureCode,
            failureMessage: failureMessage ?? self.failureMessage,
            fraudDetails: fraudDetails ?? self.fraudDetails,
            invoice: invoice ?? self.invoice,
            livemode: livemode ?? self.livemode,
            metadata: metadata ?? self.metadata,
            onBehalfOf: onBehalfOf ?? self.onBehalfOf,
            order: order ?? self.order,
            outcome: outcome ?? self.outcome,
            paid: paid ?? self.paid,
            paymentIntent: paymentIntent ?? self.paymentIntent,
            paymentMethod: paymentMethod ?? self.paymentMethod,
            paymentMethodDetails: paymentMethodDetails ?? self.paymentMethodDetails,
            receiptEmail: receiptEmail ?? self.receiptEmail,
            receiptNumber: receiptNumber ?? self.receiptNumber,
            receiptURL: receiptURL ?? self.receiptURL,
            refunded: refunded ?? self.refunded,
            refunds: refunds ?? self.refunds,
            review: review ?? self.review,
            shipping: shipping ?? self.shipping,
            source: source ?? self.source,
            sourceTransfer: sourceTransfer ?? self.sourceTransfer,
            statementDescriptor: statementDescriptor ?? self.statementDescriptor,
            statementDescriptorSuffix: statementDescriptorSuffix ?? self.statementDescriptorSuffix,
            status: status ?? self.status,
            transferData: transferData ?? self.transferData,
            transferGroup: transferGroup ?? self.transferGroup
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - BillingDetails
struct BillingDetails: Codable {
    let address: Address?
    let email, name, phone: JSONNull?
}

// MARK: BillingDetails convenience initializers and mutators

extension BillingDetails {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(BillingDetails.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        address: Address?? = nil,
        email: JSONNull?? = nil,
        name: JSONNull?? = nil,
        phone: JSONNull?? = nil
    ) -> BillingDetails {
        return BillingDetails(
            address: address ?? self.address,
            email: email ?? self.email,
            name: name ?? self.name,
            phone: phone ?? self.phone
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Address
struct Address: Codable {
    let city, country, line1: String?
    let line2: JSONNull?
    let postalCode, state: String?

    enum CodingKeys: String, CodingKey {
        case city, country, line1, line2
        case postalCode
        case state
    }
}

// MARK: Address convenience initializers and mutators

extension Address {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Address.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        city: String?? = nil,
        country: String?? = nil,
        line1: String?? = nil,
        line2: JSONNull?? = nil,
        postalCode: String?? = nil,
        state: String?? = nil
    ) -> Address {
        return Address(
            city: city ?? self.city,
            country: country ?? self.country,
            line1: line1 ?? self.line1,
            line2: line2 ?? self.line2,
            postalCode: postalCode ?? self.postalCode,
            state: state ?? self.state
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - FraudDetails
struct FraudDetails: Codable {
}

// MARK: FraudDetails convenience initializers and mutators

extension FraudDetails {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FraudDetails.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> FraudDetails {
        return FraudDetails(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Outcome
struct Outcome: Codable {
    let networkStatus: String?
    let reason: JSONNull?
    let riskLevel: String?
    let riskScore: Int?
    let sellerMessage, type: String?

    enum CodingKeys: String, CodingKey {
        case networkStatus
        case reason
        case riskLevel
        case riskScore
        case sellerMessage
        case type
    }
}

// MARK: Outcome convenience initializers and mutators

extension Outcome {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Outcome.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        networkStatus: String?? = nil,
        reason: JSONNull?? = nil,
        riskLevel: String?? = nil,
        riskScore: Int?? = nil,
        sellerMessage: String?? = nil,
        type: String?? = nil
    ) -> Outcome {
        return Outcome(
            networkStatus: networkStatus ?? self.networkStatus,
            reason: reason ?? self.reason,
            riskLevel: riskLevel ?? self.riskLevel,
            riskScore: riskScore ?? self.riskScore,
            sellerMessage: sellerMessage ?? self.sellerMessage,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PaymentMethodDetails
struct PaymentMethodDetails: Codable {
    let card: Card?
    let type: String?
}

// MARK: PaymentMethodDetails convenience initializers and mutators

extension PaymentMethodDetails {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PaymentMethodDetails.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        card: Card?? = nil,
        type: String?? = nil
    ) -> PaymentMethodDetails {
        return PaymentMethodDetails(
            card: card ?? self.card,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Card
struct Card: Codable {
    let brand: String?
    let checks: Checks?
    let country: String?
    let expMonth, expYear: Int?
    let fingerprint, funding: String?
    let installments: JSONNull?
    let last4, network: String?
    let threeDSecure, wallet: JSONNull?

    enum CodingKeys: String, CodingKey {
        case brand, checks, country
        case expMonth
        case expYear
        case fingerprint, funding, installments, last4, network
        case threeDSecure
        case wallet
    }
}

// MARK: Card convenience initializers and mutators

extension Card {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Card.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        brand: String?? = nil,
        checks: Checks?? = nil,
        country: String?? = nil,
        expMonth: Int?? = nil,
        expYear: Int?? = nil,
        fingerprint: String?? = nil,
        funding: String?? = nil,
        installments: JSONNull?? = nil,
        last4: String?? = nil,
        network: String?? = nil,
        threeDSecure: JSONNull?? = nil,
        wallet: JSONNull?? = nil
    ) -> Card {
        return Card(
            brand: brand ?? self.brand,
            checks: checks ?? self.checks,
            country: country ?? self.country,
            expMonth: expMonth ?? self.expMonth,
            expYear: expYear ?? self.expYear,
            fingerprint: fingerprint ?? self.fingerprint,
            funding: funding ?? self.funding,
            installments: installments ?? self.installments,
            last4: last4 ?? self.last4,
            network: network ?? self.network,
            threeDSecure: threeDSecure ?? self.threeDSecure,
            wallet: wallet ?? self.wallet
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Checks
struct Checks: Codable {
    let addressLine1Check, addressPostalCodeCheck, cvcCheck: JSONNull?

    enum CodingKeys: String, CodingKey {
        case addressLine1Check
        case addressPostalCodeCheck
        case cvcCheck
    }
}

// MARK: Checks convenience initializers and mutators

extension Checks {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Checks.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        addressLine1Check: JSONNull?? = nil,
        addressPostalCodeCheck: JSONNull?? = nil,
        cvcCheck: JSONNull?? = nil
    ) -> Checks {
        return Checks(
            addressLine1Check: addressLine1Check ?? self.addressLine1Check,
            addressPostalCodeCheck: addressPostalCodeCheck ?? self.addressPostalCodeCheck,
            cvcCheck: cvcCheck ?? self.cvcCheck
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Refunds
struct Refunds: Codable {
    let object: String?
    let data: [Source]?
    let hasMore: Bool?
    let totalCount: Int?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case object, data
        case hasMore
        case totalCount
        case url
    }
}

// MARK: Refunds convenience initializers and mutators

extension Refunds {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Refunds.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        object: String?? = nil,
        data: [Source]?? = nil,
        hasMore: Bool?? = nil,
        totalCount: Int?? = nil,
        url: String?? = nil
    ) -> Refunds {
        return Refunds(
            object: object ?? self.object,
            data: data ?? self.data,
            hasMore: hasMore ?? self.hasMore,
            totalCount: totalCount ?? self.totalCount,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Source
struct Source: Codable {
    let id, object: String?
    let addressCity, addressCountry, addressLine1, addressLine1Check: JSONNull?
    let addressLine2, addressState, addressZip, addressZipCheck: JSONNull?
    let brand, country, customer: String?
    let cvcCheck: String?
    let dynamicLast4: JSONNull?
    let expMonth, expYear: Int?
    let fingerprint, funding, last4: String?
    let metadata: FraudDetails?
    let name, tokenizationMethod: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, object
        case addressCity
        case addressCountry
        case addressLine1
        case addressLine1Check
        case addressLine2
        case addressState
        case addressZip
        case addressZipCheck
        case brand, country, customer
        case cvcCheck
        case dynamicLast4
        case expMonth
        case expYear
        case fingerprint, funding, last4, metadata, name
        case tokenizationMethod
    }
}

// MARK: Source convenience initializers and mutators

extension Source {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Source.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        object: String?? = nil,
        addressCity: JSONNull?? = nil,
        addressCountry: JSONNull?? = nil,
        addressLine1: JSONNull?? = nil,
        addressLine1Check: JSONNull?? = nil,
        addressLine2: JSONNull?? = nil,
        addressState: JSONNull?? = nil,
        addressZip: JSONNull?? = nil,
        addressZipCheck: JSONNull?? = nil,
        brand: String?? = nil,
        country: String?? = nil,
        customer: String?? = nil,
        cvcCheck: String?? = nil,
        dynamicLast4: JSONNull?? = nil,
        expMonth: Int?? = nil,
        expYear: Int?? = nil,
        fingerprint: String?? = nil,
        funding: String?? = nil,
        last4: String?? = nil,
        metadata: FraudDetails?? = nil,
        name: JSONNull?? = nil,
        tokenizationMethod: JSONNull?? = nil
    ) -> Source {
        return Source(
            id: id ?? self.id,
            object: object ?? self.object,
            addressCity: addressCity ?? self.addressCity,
            addressCountry: addressCountry ?? self.addressCountry,
            addressLine1: addressLine1 ?? self.addressLine1,
            addressLine1Check: addressLine1Check ?? self.addressLine1Check,
            addressLine2: addressLine2 ?? self.addressLine2,
            addressState: addressState ?? self.addressState,
            addressZip: addressZip ?? self.addressZip,
            addressZipCheck: addressZipCheck ?? self.addressZipCheck,
            brand: brand ?? self.brand,
            country: country ?? self.country,
            customer: customer ?? self.customer,
            cvcCheck: cvcCheck ?? self.cvcCheck,
            dynamicLast4: dynamicLast4 ?? self.dynamicLast4,
            expMonth: expMonth ?? self.expMonth,
            expYear: expYear ?? self.expYear,
            fingerprint: fingerprint ?? self.fingerprint,
            funding: funding ?? self.funding,
            last4: last4 ?? self.last4,
            metadata: metadata ?? self.metadata,
            name: name ?? self.name,
            tokenizationMethod: tokenizationMethod ?? self.tokenizationMethod
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CustomerResponse
struct CustomerResponse: Codable {
    let id, object: String?
    let address: Address?
    let balance, created: Int?
    let currency: JSONNull?
    let defaultSource: String?
    let delinquent: Bool?
    let customerResponseDescription: String?
    let discount: JSONNull?
    let email, invoicePrefix: String?
    let invoiceSettings: InvoiceSettings?
    let livemode: Bool?
    let metadata: FraudDetails?
    let name: String?
    let phone: JSONNull?
    let preferredLocales: [JSONAny]?
    let shipping: JSONNull?
    let sources, subscriptions: Refunds?
    let taxExempt: String?
    let taxIDS: Refunds?

    enum CodingKeys: String, CodingKey {
        case id, object, address, balance, created, currency
        case defaultSource
        case delinquent
        case customerResponseDescription
        case discount, email
        case invoicePrefix
        case invoiceSettings
        case livemode, metadata, name, phone
        case preferredLocales
        case shipping, sources, subscriptions
        case taxExempt
        case taxIDS
    }
}

// MARK: CustomerResponse convenience initializers and mutators

extension CustomerResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CustomerResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        object: String?? = nil,
        address: Address?? = nil,
        balance: Int?? = nil,
        created: Int?? = nil,
        currency: JSONNull?? = nil,
        defaultSource: String?? = nil,
        delinquent: Bool?? = nil,
        customerResponseDescription: String?? = nil,
        discount: JSONNull?? = nil,
        email: String?? = nil,
        invoicePrefix: String?? = nil,
        invoiceSettings: InvoiceSettings?? = nil,
        livemode: Bool?? = nil,
        metadata: FraudDetails?? = nil,
        name: String?? = nil,
        phone: JSONNull?? = nil,
        preferredLocales: [JSONAny]?? = nil,
        shipping: JSONNull?? = nil,
        sources: Refunds?? = nil,
        subscriptions: Refunds?? = nil,
        taxExempt: String?? = nil,
        taxIDS: Refunds?? = nil
    ) -> CustomerResponse {
        return CustomerResponse(
            id: id ?? self.id,
            object: object ?? self.object,
            address: address ?? self.address,
            balance: balance ?? self.balance,
            created: created ?? self.created,
            currency: currency ?? self.currency,
            defaultSource: defaultSource ?? self.defaultSource,
            delinquent: delinquent ?? self.delinquent,
            customerResponseDescription: customerResponseDescription ?? self.customerResponseDescription,
            discount: discount ?? self.discount,
            email: email ?? self.email,
            invoicePrefix: invoicePrefix ?? self.invoicePrefix,
            invoiceSettings: invoiceSettings ?? self.invoiceSettings,
            livemode: livemode ?? self.livemode,
            metadata: metadata ?? self.metadata,
            name: name ?? self.name,
            phone: phone ?? self.phone,
            preferredLocales: preferredLocales ?? self.preferredLocales,
            shipping: shipping ?? self.shipping,
            sources: sources ?? self.sources,
            subscriptions: subscriptions ?? self.subscriptions,
            taxExempt: taxExempt ?? self.taxExempt,
            taxIDS: taxIDS ?? self.taxIDS
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - InvoiceSettings
struct InvoiceSettings: Codable {
    let customFields, defaultPaymentMethod, footer: JSONNull?

    enum CodingKeys: String, CodingKey {
        case customFields
        case defaultPaymentMethod
        case footer
    }
}

// MARK: InvoiceSettings convenience initializers and mutators

extension InvoiceSettings {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(InvoiceSettings.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        customFields: JSONNull?? = nil,
        defaultPaymentMethod: JSONNull?? = nil,
        footer: JSONNull?? = nil
    ) -> InvoiceSettings {
        return InvoiceSettings(
            customFields: customFields ?? self.customFields,
            defaultPaymentMethod: defaultPaymentMethod ?? self.defaultPaymentMethod,
            footer: footer ?? self.footer
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let id, object: String?
    let card: Source?
    let clientIP: String?
    let created: Int?
    let livemode: Bool?
    let type: String?
    let used: Bool?

    enum CodingKeys: String, CodingKey {
        case id, object, card
        case clientIP
        case created, livemode, type, used
    }
}

// MARK: TokenResponse convenience initializers and mutators

extension TokenResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TokenResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        object: String?? = nil,
        card: Source?? = nil,
        clientIP: String?? = nil,
        created: Int?? = nil,
        livemode: Bool?? = nil,
        type: String?? = nil,
        used: Bool?? = nil
    ) -> TokenResponse {
        return TokenResponse(
            id: id ?? self.id,
            object: object ?? self.object,
            card: card ?? self.card,
            clientIP: clientIP ?? self.clientIP,
            created: created ?? self.created,
            livemode: livemode ?? self.livemode,
            type: type ?? self.type,
            used: used ?? self.used
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
