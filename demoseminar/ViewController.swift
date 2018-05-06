//
//  ViewController.swift
//  demoseminar
//
//  Created by Nguyễn Đệ on 5/6/18.
//  Copyright © 2018 Nguyễn Đệ. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var coins = 50
    
    @IBOutlet weak var lblAds: UILabel!
    
    @IBOutlet weak var lblCoins: UILabel!
    @IBOutlet weak var outRemoveAds: UIButton!
    @IBOutlet weak var outAddCoins: UIButton!
    @IBOutlet weak var outRestore: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        outRemoveAds.isEnabled = false
        outAddCoins.isEnabled = false
        outRestore.isEnabled = false
        // Set IAPS
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            let productID:NSSet = NSSet(objects: "com.dn97.demoseminar.coin", "com.dn97.demoseminar.removeads")
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnRemoveAds(_ sender: Any) {
        for product in list {
            let prodID = product.productIdentifier
            if(prodID == "com.dn97.demoseminar.removeads") {
                p = product
                buyProduct()
                break;
            }
        }
    }
    
    @IBAction func btnAddCoins(_ sender: Any) {
        for product in list {
            let prodID = product.productIdentifier
            if(prodID == "com.dn97.demoseminar.coin") {
                p = product
                buyProduct()
                break;
            }
        }
    }
   
    @IBAction func btnRestore(_ sender: Any) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func buyProduct() {
        print("buy " + p.productIdentifier)
        let pay = SKPayment(product: p)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(pay as SKPayment)
    }
    func removeAds(){
        lblAds.removeFromSuperview()
    }
    func addCoins(){
        coins += 50
        lblCoins.text = "\(coins)"
    }
    var list = [SKProduct]()
    var p = SKProduct()
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("product request")
        let myProduct = response.products
        
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            
            list.append(product )
        }
        outRemoveAds.isEnabled = true
        outAddCoins.isEnabled = true
        outRestore.isEnabled = true
        
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("transactions restored")
        
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
            case "com.dn97.demoseminar.removeads":
                print("remove ads")
                removeAds()
            case "com.dn97.demoseminar.coin":
                print("add coins to account")
                addCoins()
            default:
                print("IAP not setup")
            }
            
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("add paymnet")
        
        for transaction:AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            print(trans.error!)
            
            switch trans.transactionState {
                
            case .purchased:
                print("buy, ok unlock iap here")
                print(p.productIdentifier)
                
                let prodID = p.productIdentifier as String
                switch prodID {
                case "com.dn97.demoseminar.removeads":
                    print("remove ads")
                    removeAds()
                case "com.dn97.demoseminar.coin":
                    print("add coins to account")
                    addCoins()
                default:
                    print("IAP not setup")
                }
                
                queue.finishTransaction(trans)
                break;
            case .failed:
                print("buy error")
                queue.finishTransaction(trans)
                break;
            default:
                print("default")
                break;
                
            }
        }
    }

}

