//
//  ChangeLangVC.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import UIKit

protocol ChangeLanguage {
    func userSetANewLanguages(top: LanguageTA, bottom: LanguageTA)
}

class ChangeLangVC: UIViewController {
    
    let defaults = UserDefaults.standard
    static let topLangPickerKey = "topTranslatorPicker"
    static let bottomLangPickerKey = "bottomTranslatorPicker"
    static let topLangCodeKey = "topTranslatorCode"
    static let bottomLangCodeKey = "bottomTranslatorCode"
    static let topLanguageKey = "topLanguage"
    static let bottomLanguageKey = "bottomLanguage"
    static let topLangImageKey = "topTranslatorImage"
    static let bottomLangImageKey = "bottomTranslatorImage"

    @IBOutlet weak var topLangPicker: UIPickerView!
    @IBOutlet weak var botLangPicker: UIPickerView!
    
    var delegate : ChangeLanguage?
    var userLangChoice : Languages!
    var language = WorldLanguages()
    
    var topPickerViewOptions = [(code: String, language: String, flag: UIImage, country: String)]()
    var botPickerViewOptions = [(code: String, language: String, flag: UIImage, country: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting the pickerView delegate
        self.topLangPicker.delegate = self
        self.topLangPicker.dataSource = self
        self.botLangPicker.delegate = self
        self.botLangPicker.dataSource = self
        topPickerViewOptions = language.worldLanguages
        botPickerViewOptions = language.worldLanguages
        
        //Show the user pickerView last position
        setPickerViewToUserSelection()
    }
    
    //Picking top and bottom pickerView choices
    func createTopandBotLang(){
        let topUserIndex = topLangPicker.selectedRow(inComponent: 0)
        let botUserIndex = botLangPicker.selectedRow(inComponent: 0)
        let topUserChoice = language.worldLanguages[topUserIndex]
        let bottomUserChoice = language.worldLanguages[botUserIndex]
        userLangChoice = Languages(top: topUserChoice, bot: bottomUserChoice)
        
        //Save the user pickerViews choice
        defaults.set(topUserIndex, forKey: ChangeLangVC.topLangPickerKey)
        defaults.set(botUserIndex, forKey: ChangeLangVC.bottomLangPickerKey)
        defaults.set(userLangChoice.top.code, forKey: ChangeLangVC.topLangCodeKey)
        defaults.set(userLangChoice.bot.code, forKey: ChangeLangVC.bottomLangCodeKey)
        defaults.set(userLangChoice.top.language, forKey: ChangeLangVC.topLanguageKey)
        defaults.set(userLangChoice.bot.language, forKey: ChangeLangVC.bottomLanguageKey)
        defaults.set(userLangChoice.top.country, forKey: ChangeLangVC.topLangImageKey)
        defaults.set(userLangChoice.bot.country, forKey: ChangeLangVC.bottomLangImageKey)
    }
    
    @IBAction func saveSettingsPressed(_ sender: Any) {
        createTopandBotLang()
        delegate?.userSetANewLanguages(top: userLangChoice.top, bottom: userLangChoice.bot)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//Set the pickerView options
extension ChangeLangVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return topPickerViewOptions.count
        } else {
            return botPickerViewOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return topPickerViewOptions[row].language
        }
        else {
            return botPickerViewOptions[row].language
        }
    }
}

//Set pickerViews to user selections
extension ChangeLangVC {
    func setPickerViewToUserSelection(){
        topLangPicker.selectRow(defaults.integer(forKey: ChangeLangVC.topLangPickerKey), inComponent: 0, animated: true)
        botLangPicker.selectRow(defaults.integer(forKey: ChangeLangVC.bottomLangPickerKey), inComponent: 0, animated: true)
    }
}

