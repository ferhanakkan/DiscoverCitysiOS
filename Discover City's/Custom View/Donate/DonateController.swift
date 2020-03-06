//
//  DonateController.swift
//  DiscoverCity
//
//  Created by ferhan akkan on 4.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import StoreKit

class DonateController: UIViewController, SKPaymentTransactionObserver {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dismissView: UIView!
    
    @IBOutlet weak var donateOne: UIView!
    @IBOutlet weak var donateFive: UIView!
    @IBOutlet weak var donateTen: UIView!
    

    override func viewDidLoad() {
        setRadius()
        setGesture()
        SKPaymentQueue.default().add(self)
    }
    
    private func setRadius() {
        mainView.cornerRadius = 20
        donateOne.cornerRadius = 20
        donateTen.cornerRadius = 20
        donateFive.cornerRadius = 20
        
        let myColor = UIColor.rouge
        
        donateOne.layer.borderWidth = 3.0
        donateTen.layer.borderWidth = 3.0
        donateFive.layer.borderWidth = 3.0
        
        
        donateOne.layer.borderColor = myColor.cgColor
        donateTen.layer.borderColor = myColor.cgColor
        donateFive.layer.borderColor = myColor.cgColor
        
        dismissView.cornerRadius = dismissView.frame.width/2
    }
    
    private func setGesture() {
        donateOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donateOneSelection)))
        donateFive.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donateFiveselection)))
        donateTen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donateTenSelection)))
        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSelection)))
    }
    
    @objc func donateOneSelection() {
        setDonationInteraction()
        buyPremiumQuotes(productID: "com.ferhanakkan.Discover.Coffee")
    }
    
    @objc func donateFiveselection() {
        setDonationInteraction()
        buyPremiumQuotes(productID: "com.ferhanakkan.Discover.Burger")
    }
    
    @objc func donateTenSelection() {
        setDonationInteraction()
        buyPremiumQuotes(productID: "com.ferhanakkan.Discover.BurgerMenu")
    }
    
    @objc func dismissSelection() {
       dismiss(animated: true, completion: nil)
    }
    
    
}

extension DonateController {
    func buyPremiumQuotes(productID: String) {
        
         if SKPaymentQueue.canMakePayments() {
             //Can make payments
            let paymentRequest = SKMutablePayment()
             paymentRequest.productIdentifier = productID
             SKPaymentQueue.default().add(paymentRequest)
 
         } else {
             //Can't make payments
             print("User can't make payments")
         }
     }
     
     func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
         for transaction in transactions {
            switch  transaction.transactionState {
            case .purchased:
                //User payment successful
                print("Transaction successful!")
                SKPaymentQueue.default().finishTransaction(transaction)
                setDonationInteraction()
            case .failed:
                //Payment failed
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to error: \(errorDescription)")
                    setDonationInteraction()
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("Transaction restored")
                SKPaymentQueue.default().finishTransaction(transaction)
                setDonationInteraction()
            default:
                break
            }
         }
         
     }
     
     @IBAction func restorePressed(_ sender: UIBarButtonItem) {  /////DİD BUY BEFORE CHECK
         SKPaymentQueue.default().restoreCompletedTransactions()
     }
    
    private func setDonationInteraction() {
        donateOne.isUserInteractionEnabled = !donateOne.isUserInteractionEnabled
        donateFive.isUserInteractionEnabled = !donateFive.isUserInteractionEnabled
        donateTen.isUserInteractionEnabled = !donateTen.isUserInteractionEnabled
    }
}
