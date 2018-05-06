//
//  IAPService.swift
//  demoseminar
//
//  Created by Nguyễn Đệ on 5/6/18.
//  Copyright © 2018 Nguyễn Đệ. All rights reserved.
//

import Foundation
import StoreKit

class IAPService: NSObject {
    private override init() {}
    static let shared = IAPService()
    func getProducts() {
        let products: Set = [IAPProduct.consumable.rawValue, IAPProduct.nonconsumable.rawValue, IAPProduct.nonsub.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
    }
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        for product in response.products {
            print(product.localizedTitle)
        }
    }
}
