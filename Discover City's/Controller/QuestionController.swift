//
//  QuestionController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class QuestionController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    
    var questionViewModel = QuestionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        setOutlets()
        setGestRec()
    }
    
    func setOutlets() {
        questionLabel.setTextWithTypeAnimation(typedText: questionViewModel.getDescription(), characterDelay:  5)
        descriptionLabel.setTextWithTypeAnimation(typedText: questionViewModel.getQuestion(), characterDelay:  5)
        answerA.setTitle(questionViewModel.getAnswerA(), for: .normal)
        answerB.setTitle(questionViewModel.getAnswerB(), for: .normal)
        answerC.setTitle(questionViewModel.getAnswerC(), for: .normal)
        answerD.setTitle(questionViewModel.getAnswerD(), for: .normal)
        
       
        answerA.cornerRadius = 15
        answerB.cornerRadius = 15
        answerC.cornerRadius = 15
        answerD.cornerRadius = 15

        let myColor = UIColor.rouge
        answerA.layer.borderWidth = 3.0
        answerA.layer.borderColor = myColor.cgColor
        answerB.layer.borderWidth = 3.0
        answerB.layer.borderColor = myColor.cgColor
        answerC.layer.borderWidth = 3.0
        answerC.layer.borderColor = myColor.cgColor
        answerD.layer.borderWidth = 3.0
        answerD.layer.borderColor = myColor.cgColor
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if questionViewModel.doesPickerSelected {
            questionViewModel.chechAnswer(answer: sender.currentTitle!)
            questionViewModel.screenPass(owner: self)
        } else {
            present(questionViewModel.makeAlertForOneTime(), animated: true, completion: nil)
        }
    }
}
    
    //MARK: - GestRec/PickerDelegate

extension QuestionController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func setGestRec() {
        imageView.isUserInteractionEnabled = true
        let gestRect = UITapGestureRecognizer(target: self, action: #selector(imageSelector))
        imageView.addGestureRecognizer(gestRect)
    }
    
    @objc func imageSelector() {
        present(questionViewModel.setPicker(owner: self), animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil )
        imageView.image = info[.editedImage] as? UIImage
        SingletonGameManager.shared.scoreUP()
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self,nil, nil)
        imageView.isUserInteractionEnabled = false
        questionViewModel.doesPickerSelected = true
        picker.dismiss(animated: true)
    }
    
}

//MARK: - SetNavigationController

extension QuestionController {
    func setNavigationController() {
        navigationItem.hidesBackButton = true
        navigationItem.titleView = SingletonGameManager.shared.weatherUIView
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(leaveGame))

    }
    
    @objc func leaveGame() {
        SingletonGameManager.shared.overTimer()
        let message = SingletonGameManager.shared.leaveGame(self)
        self.present(message, animated: true)
    }
}
      

