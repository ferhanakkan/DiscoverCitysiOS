//
//  WelcomeController.swift
//  DiscoverCity
//
//  Created by Ferhan Akkan on 28.02.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import StoreKit

class WelcomeController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var automaticSelectionView: UIView!
    @IBOutlet weak var manualySelectionView: UIView!
    @IBOutlet weak var howToPlayView: UIView!
    @IBOutlet weak var scoreBoardView: UIView!
    @IBOutlet weak var rateView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.cornerRadius = 20
        automaticSelectionView.cornerRadius = 20
        manualySelectionView.cornerRadius = 20
        howToPlayView.cornerRadius = 15
        scoreBoardView.cornerRadius = 15
        rateView.cornerRadius = 20
        
        automaticSelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(automaticSelection)))
        manualySelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(manualySelection)))
        howToPlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(howToPlaySelection)))
        scoreBoardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scoreBoardSelection)))
        rateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rateSelection)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LoadingView.hide()
    }
    
    
    @objc private func automaticSelection(){
        print("test")
    }
    
    @objc private func manualySelection(){
        if let vc = Bundle.main.loadNibNamed("CityController", owner: self, options: nil)?.first  as? CityController {
            LoadingView.show()
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    @objc private func howToPlaySelection(){
        if let vc = Bundle.main.loadNibNamed("HowToController", owner: self, options: nil)?.first  as? HowToController {
            vc.modalPresentationStyle = .overFullScreen
            UIApplication.getPresentedViewController()!.present(vc, animated: true)
            
        }
    }
    
    @objc private func scoreBoardSelection(){
        print("test")
    }
    @objc private func rateSelection(){
        SKStoreReviewController.requestReview()
    }
}
