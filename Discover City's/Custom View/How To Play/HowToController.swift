//
//  HowToController.swift
//  DiscoverCity
//
//  Created by Ferhan Akkan on 29.02.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class HowToController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        middleView.cornerRadius = 20
        collectionView.cornerRadius = 20
        buttonOutlet.cornerRadius = 15
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HowToCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HowToCollectionViewCell")
        collectionView.isPagingEnabled = true
        pageControl.currentPage = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HowToCollectionViewCell", for: indexPath) as! HowToCollectionViewCell
        cell.descriptionLabel.text = "arabayi sat"
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
          if let row = collectionView.indexPath(for: cell)?.item {
            pageControl.currentPage = row
          }
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
