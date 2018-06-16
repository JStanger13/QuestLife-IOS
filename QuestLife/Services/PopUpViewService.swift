//
//  PopUpViewService.swift
//  QuestLife
//
//  Created by Justin Stanger on 6/11/18.
//  Copyright © 2018 Justin Stanger. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

//Heptic Feedback
let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

class PopUpViewService {
    
    private init() {}
    //set up sound effects
    static var soundEffect: AVAudioPlayer?
    
    static func setUpPopUpView(popUpView: UIView, transparentePopUpView: UIView, mView: UIView, mDimView: UIView){
        playSound(sound: "bounce-sound.aiff")
        popUpView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        popUpView.center = mView.center
        
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        
        transparentePopUpView.layer.cornerRadius = 5
        transparentePopUpView.layer.masksToBounds = true
        
        mView.addSubview(popUpView)
        
        //Setup View Animation
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            popUpView.transform = .identity
        })
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            mDimView.alpha = 0.8
        })
    }
    
    static func setBackButtonInUpPopUpView(popUpView: UIView, mDimView: UIView){
        playSound(sound: "pop-sound.wav")
        mediumImpactFeedbackGenerator.impactOccurred()
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            popUpView.removeFromSuperview()
            popUpView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }){(success) in
            popUpView.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            mDimView.alpha = 0.0
            popUpView.transform = .identity
        })
    }
    
    static func playSound(sound: String) {
        let path = Bundle.main.path(forResource: sound, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()

            do {
                try audioSession.setCategory(AVAudioSessionCategoryAmbient)

            }
            }catch{
        
        }
        soundEffect?.play()
    }
   
    
    static func setUpTextField(textField: UITextField){
        textField.becomeFirstResponder()

        
        textField.autocorrectionType = .no
        textField.text = ""
        textField.autocapitalizationType = .sentences
    }
    
    
    static func animateFadeInView(viewIsHidden: Bool, view: UIView){
        if (viewIsHidden == true) {
            UIView.animate(withDuration: 0.3/*Animation Duration second*/, animations: {
                view.alpha = 0
            }, completion:  {
                (value: Bool) in
                view.isHidden = true
            })
        }else{
           view.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 1  }, completion:  nil)
        }
    }
   
    static func hepticFeedback (type: String){
        switch type {
        
        case "light":
            lightImpactFeedbackGenerator.impactOccurred()

            break
        
        case "medium":
            mediumImpactFeedbackGenerator.impactOccurred()

            break
        
        case "heavy":
            heavyImpactFeedbackGenerator.impactOccurred()
            break
        
        default:
            print("error")
            break
        }
    }
}
