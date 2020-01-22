//
//  QuestionController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import CLTypingLabel

class QuestionController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionLabel: CLTypingLabel!
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
        questionLabel.text = questionViewModel.getQuestion()
        descriptionLabel.text = questionViewModel.getDescription()
        answerA.setTitle(questionViewModel.getAnswerA(), for: .normal)
        answerB.setTitle(questionViewModel.getAnswerB(), for: .normal)
        answerC.setTitle(questionViewModel.getAnswerC(), for: .normal)
        answerD.setTitle(questionViewModel.getAnswerD(), for: .normal)
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
    }
}
      

