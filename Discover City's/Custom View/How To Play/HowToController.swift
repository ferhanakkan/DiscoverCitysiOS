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
    
    var datas: [HowToModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHowToPlay()
        middleView.cornerRadius = 20
        collectionView.cornerRadius = 20
        buttonOutlet.cornerRadius = 15
        
        let myColor = UIColor.rouge
        
        buttonOutlet.layer.borderWidth = 3.0
        buttonOutlet.layer.borderColor = myColor.cgColor
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HowToCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HowToCollectionViewCell")
        collectionView.isPagingEnabled = true
        pageControl.currentPage = 0
        pageControl.numberOfPages = datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HowToCollectionViewCell", for: indexPath) as! HowToCollectionViewCell
        cell.descriptionLabel.text = datas[indexPath.row].description
        cell.titleLabel.text = datas[indexPath.row].title
        cell.imageView.image = UIImage(named: datas[indexPath.row].image)
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
    
    func setHowToPlay() {
        datas.append(HowToModel(image: "main", title: "How to start a game?", description: "In main menu there is two options. First one is Select Area Automatically when you select that one we will search a game on your city. Second one is Select Area Manualy when you select that one you will see all available city's."))
        datas.append(HowToModel(image: "city", title: "Select a city", description: "In this screen you gonna see city's also distance from you to game area, you can select which one do you prefer "))
        datas.append(HowToModel(image: "area", title: "Select a area", description: "It's almost same as previous screen you gonna select a area which area do you prefer. It's able to be multiple area."))
        datas.append(HowToModel(image: "map", title: "What should you do in map screen", description: "When you select area than we will show you a map screen. We will show you road to destination by walking. How fast you gonna be there you gonna earn more points."))
        datas.append(HowToModel(image: "history", title: "Historical informations", description: "When you arrive in a destination than we will show you that screen. There is historical information about your destination point."))
        datas.append(HowToModel(image: "question", title: "Time to ask a question", description: "Question side there is two step first one is we gonna ask you a question about your historical destination area which we did give historical information in previous page. Second step you can take a photo and that gonna save in your Libary not gonna shared. Both steps gonna give you points."))
        datas.append(HowToModel(image: "score", title: "Score", description: "In final screen we gonna show your game score to you, we hope you gonna enjoy."))
    }
}


struct HowToModel {
    let image: String
    let title: String
    let description: String
}
