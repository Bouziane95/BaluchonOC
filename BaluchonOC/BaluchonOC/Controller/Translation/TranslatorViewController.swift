//
//  TranslatorViewController.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation
import UIKit

class TranslatorViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var params = [String: String]()
    
    @IBOutlet weak var topFlag: UIButton!
    @IBOutlet weak var botFlag: UIButton!
    @IBOutlet weak var translatorInput: UITextView!
    @IBOutlet weak var translatorOutput: UITextView!
    @IBOutlet weak var botLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var changeLangButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpParamsAtLaunch()
    }
    
    @IBAction func swapTxt(_ sender: UIButton) {
        clearText()
        TranslatorAPI.shared.swapTexts(&topLabel.text, &botLabel.text)
        TranslatorAPI.shared.swapTexts(&translatorInput.text, &translatorOutput.text)
        if let topFlagImageview = topFlag.imageView,
            let bottomFlagImageView = botFlag.imageView{
            topFlag.setImage(bottomFlagImageView.image, for: .normal)
            botFlag.setImage(topFlagImageview.image, for: .normal)
        }
        params = ["source": params["target"]!, "target": params["source"]!]
    }
    
    //To erase the text input and output
    func clearText(){
        translatorInput.text! = ""
        translatorOutput.text! = ""
    }
    
    //Button pressed to get the translation
   
    @IBAction func translate(_ sender: UIButton) {
        translatorOutput.text! = ""
        TranslatorAPI.shared.getTranslation(q: translatorInput.text!, source: params["source"]!, target: params["target"]!) {
            (success,translationResult) in
            if success, let translationResult = translationResult{
                self.translatorOutput.text! = translationResult
            }
            else{
                self.presentAlert()
            }
        }
    }
    
    //Show an alert to the user if there is no data coming back from network
    func presentAlert(){
        let alertVC = UIAlertController(title: "Error", message: "Error with getting the data", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func changeTopLang(_ sender: Any) {
        performSegue(withIdentifier: "goToChangeCountry", sender: self)
    }
    
    @IBAction func changeBotLang(_ sender: Any) {
        performSegue(withIdentifier: "goToChangeCountry", sender: self)
    }
    
    //Dismiss the keyboard when the user tap on the screen
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translatorInput.resignFirstResponder()
        translatorOutput.resignFirstResponder()
    }
    
    func setUpParamsAtLaunch(){
        if defaults.object(forKey: ChangeLangVC.topLangPickerKey) != nil{
            setUserSavedParameters()
        }
        else {
            setDefaultsParameters()
        }
    }
    
    func setUserSavedParameters(){
        topLabel.text! = defaults.string(forKey: ChangeLangVC.topLanguageKey)!
        botLabel.text! = defaults.string(forKey: ChangeLangVC.bottomLanguageKey)!
        topFlag.setImage(UIImage(named: defaults.string(forKey: ChangeLangVC.topLangImageKey)!), for: .normal)
        botFlag.setImage(UIImage(named: defaults.string(forKey: ChangeLangVC.bottomLangImageKey)!), for: .normal)
        params = ["source": defaults.string(forKey: ChangeLangVC.topLangCodeKey)!, "target": defaults.string(forKey: ChangeLangVC.bottomLangCodeKey)!]
    }
    
    func setDefaultsParameters(){
        params = ["source": "fr", "target": "en"]
        topFlag.setImage(#imageLiteral(resourceName: "france"), for: .normal)
        botFlag.setImage(#imageLiteral(resourceName: "united-kingdom"), for: .normal)
        topLabel.text! = "French"
        botLabel.text! = "English"
        
    }
}

//Delegate of the ChangeLanguage protocol for the users preferences
extension TranslatorViewController: ChangeLanguage{
    func userSetANewLanguages(top: LanguageTA, bottom: LanguageTA) {
        self.topFlag.setImage(top.flag, for: .normal)
        self.botFlag.setImage(bottom.flag, for: .normal)
        self.topLabel.text = top.language
        self.botLabel.text = bottom.language
        clearText()
        params = ["source": top.code, "target": bottom.code]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChangeCountry"{
            let destinationVC = segue.destination as! ChangeLangVC
            destinationVC.delegate = self
        }
    }
}


