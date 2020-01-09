//
//  TranslatorModel.swift
//  BaluchonOC
//
//  Created by Bouziane Bey on 09/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

import Foundation

import UIKit

typealias LanguageTA = (code: String, language: String, flag: UIImage, country: String)

struct Languages {
    var top: LanguageTA
    var bot: LanguageTA
}

struct TranslationResult: Decodable {
    var result: String
}

struct LanguageOrigin: Decodable {
    var data : Translations
}

struct Translations: Decodable {
    let translations: [TranslatedText]
}

struct TranslatedText: Decodable {
    let translatedText: String
}

class WorldLanguages {
    let worldLanguages: [LanguageTA] = [
        ("af", "Afrikaans", #imageLiteral(resourceName: "south-africa"), "south-africa.png"),
        ("sq", "Albanian", #imageLiteral(resourceName: "albania"), "albania.png"),
        ("am", "Amharic", #imageLiteral(resourceName: "ethiopia"), "ethiopia.png"),
        ("ar", "Arabic", #imageLiteral(resourceName: "united-arab-emirates"), "united-arab-emirates.png"),
        ("hy", "Armenian", #imageLiteral(resourceName: "armenia"), "armenia.png"),
        ("az", "Azerbaijani", #imageLiteral(resourceName: "azerbaijan"), "azerbaijan.png"),
        ("eu", "Basque", #imageLiteral(resourceName: "basque-country"), "basque-country.png"),
        ("be", "Belarusian", #imageLiteral(resourceName: "belarus"), "belarus.png"),
        ("bn", "Bengali", #imageLiteral(resourceName: "bangladesh"), "bangladesh.png"),
        ("bs", "Bosnian", #imageLiteral(resourceName: "bosnia-and-herzegovina"), "bosnia-and-herzegovina.png"),
        ("bg", "Bulgarian", #imageLiteral(resourceName: "bulgaria"), "bulgaria.png"),
        ("ca", "Catalan", #imageLiteral(resourceName: "spain"), "spain.png"),
        ("ceb", "Cebuano", #imageLiteral(resourceName: "philippines"), "philippines.png"),
        ("zh-CN", "Chinese (Simplified)", #imageLiteral(resourceName: "china"), "china.png"),
        ("zh-TW", "Chinese (Traditional)", #imageLiteral(resourceName: "china"), "china.png"),
        ("co", "Corsican", #imageLiteral(resourceName: "corsica"), "corsica.png"),
        ("hr", "Croatian", #imageLiteral(resourceName: "croatia"), "croatia.png"),
        ("cs", "Czech", #imageLiteral(resourceName: "czech-republic"), "czech-republic.png"),
        ("da", "Danish", #imageLiteral(resourceName: "denmark"), "denmark.png"),
        ("nl", "Dutch", #imageLiteral(resourceName: "netherlands"), "netherlands.png"),
        ("en", "English", #imageLiteral(resourceName: "united-kingdom"), "united-kingdom.png"),
        ("eo", "Esperanto", #imageLiteral(resourceName: "nigeria"), "nigeria.png"),
        ("et", "Estonian", #imageLiteral(resourceName: "estonia"), "estonia.png"),
        ("fi", "Finnish", #imageLiteral(resourceName: "finland"), "finland.png"),
        ("fr", "French", #imageLiteral(resourceName: "france"), "france.png"),
        ("fy", "Frisian", #imageLiteral(resourceName: "netherlands"), "netherlands.png"),
        ("gl", "Galician", #imageLiteral(resourceName: "spain"), "spain.png"),
        ("ka", "Georgian", #imageLiteral(resourceName: "georgia"), "georgia.png"),
        ("de", "German", #imageLiteral(resourceName: "germany"), "germany.png"),
        ("el", "Greek", #imageLiteral(resourceName: "greece"), "greece.png"),
        ("gu", "Gujarati", #imageLiteral(resourceName: "india"), "india.png"),
        ("ht", "Haitian Creole", #imageLiteral(resourceName: "haiti"), "haiti.png"),
        ("ha", "Hausa", #imageLiteral(resourceName: "nigeria"), "nigeria.png"),
        ("haw", "Hawaiian", #imageLiteral(resourceName: "hawaii"), "hawaii.png"),
        ("he", "Hebrew", #imageLiteral(resourceName: "israel"), "israel.png"),
        ("hi", "Hindi", #imageLiteral(resourceName: "india"), "india.png"),
        ("hmn", "Hmong", #imageLiteral(resourceName: "spain"), "spain.png"),
        ("hu", "Hungarian", #imageLiteral(resourceName: "hungary"), "hungary.png"),
        ("is", "Icelandic", #imageLiteral(resourceName: "iceland"), "iceland.png"),
        ("ig", "Igbo", #imageLiteral(resourceName: "nigeria"), "nigeria.png"),
        ("id", "Indonesian", #imageLiteral(resourceName: "monaco"), "monaco.png"),
        ("ga", "Irish", #imageLiteral(resourceName: "ireland"), "ireland.png"),
        ("it", "Italian", #imageLiteral(resourceName: "italy"), "italy.png"),
        ("ja", "Japanese", #imageLiteral(resourceName: "japan"), "japan.png"),
        ("jw", "Javanese", #imageLiteral(resourceName: "monaco"), "monaco.png"),
        ("kn", "Kannada", #imageLiteral(resourceName: "india"), "india.png"),
        ("kk", "Kazakh", #imageLiteral(resourceName: "kazakhstan"), "kazakhstan.png"),
        ("km", "Khmer", #imageLiteral(resourceName: "cambodia"), "cambodia.png"),
        ("ko", "Korean", #imageLiteral(resourceName: "south-korea"), "south-korea.png"),
        ("ku", "Kurdish", #imageLiteral(resourceName: "iran"), "iran.png"),
        ("ky", "Kyrgyz", #imageLiteral(resourceName: "kyrgyzstan"), "kyrgyzstan.png"),
        ("lo", "Lao", #imageLiteral(resourceName: "laos"), "laos.png"),
        ("la", "Latin", #imageLiteral(resourceName: "italy"), "italy.png"),
        ("lv", "Latvian", #imageLiteral(resourceName: "latvia"), "latvia.png"),
        ("lt", "Lithuanian", #imageLiteral(resourceName: "lithuania"), "lithuania.png"),
        ("lb", "Luxembourgish", #imageLiteral(resourceName: "luxembourg"), "luxembourg.png"),
        ("mk", "Macedonian", #imageLiteral(resourceName: "republic-of-macedonia"), "republic-of-macedonia.png"),
        ("mg", "Malagasy", #imageLiteral(resourceName: "madagascar"), "madagascar.png"),
        ("ms", "Malay", #imageLiteral(resourceName: "malaysia"), "malaysia.png"),
        ("ml", "Malayalam", #imageLiteral(resourceName: "india"), "india.png"),
        ("mt", "Maltese", #imageLiteral(resourceName: "malta"), "malta.png"),
        ("mi", "Maori", #imageLiteral(resourceName: "new-zealand"), "new-zealand.png"),
        ("mr", "Marathi", #imageLiteral(resourceName: "india"), "india.png"),
        ("mn", "Mongolian", #imageLiteral(resourceName: "mongolia"), "mongolia.png"),
        ("my", "Myanmar (Burmese)", #imageLiteral(resourceName: "myanmar"), "myanmar.png"),
        ("ne", "Nepali", #imageLiteral(resourceName: "nepal"), "nepal.png"),
        ("no", "Norwegian", #imageLiteral(resourceName: "norway"), "norway.png"),
        ("ny", "Nyanja (Chichewa)", #imageLiteral(resourceName: "zambia"), "zambia.png"),
        ("ps", "Pashto", #imageLiteral(resourceName: "iran"), "iran.png"),
        ("fa", "Persian", #imageLiteral(resourceName: "iran"), "iran.png"),
        ("pl", "Polish", #imageLiteral(resourceName: "republic-of-poland"), "republic-of-poland.png"),
        ("pt", "Portuguese", #imageLiteral(resourceName: "portugal"), "portugal.png"),
        ("pa", "Punjabi", #imageLiteral(resourceName: "pakistan"), "pakistan.png"),
        ("ro", "Romanian", #imageLiteral(resourceName: "romania"), "romania.png"),
        ("ru", "Russian", #imageLiteral(resourceName: "russia"), "russia.png"),
        ("sm", "Samoan", #imageLiteral(resourceName: "samoa"), "samoa.png"),
        ("gd", "Scots Gaelic", #imageLiteral(resourceName: "scotland"), "scotland.png"),
        ("sr", "Serbian", #imageLiteral(resourceName: "serbia"), "serbia.png"),
        ("st", "Sesotho", #imageLiteral(resourceName: "south-africa"), "south-africa.png"),
        ("sn", "Shona", #imageLiteral(resourceName: "zimbabwe"), "zimbabwe.png"),
        ("sd", "Sindhi", #imageLiteral(resourceName: "india"), "india.png"),
        ("si", "Sinhala (Sinhalese)", #imageLiteral(resourceName: "sri-lanka"), "sri-lanka.png"),
        ("sk", "Slovak", #imageLiteral(resourceName: "slovakia"), "slovakia.png"),
        ("sl", "Slovenian", #imageLiteral(resourceName: "slovenia"), "slovenia.png"),
        ("so", "Somali", #imageLiteral(resourceName: "somalia"), "somalia.png"),
        ("es", "Spanish", #imageLiteral(resourceName: "spain"), "spain.png"),
        ("su", "Sundanese", #imageLiteral(resourceName: "sudan"), "sudan.png"),
        ("sw", "Swahili", #imageLiteral(resourceName: "tanzania"), "tanzania.png"),
        ("sv", "Swedish", #imageLiteral(resourceName: "sweden"), "sweden.png"),
        ("tl", "Tagalog (Filipino)", #imageLiteral(resourceName: "philippines"), "philippines.png"),
        ("tg", "Tajik", #imageLiteral(resourceName: "tajikistan"), "tajikistan.png"),
        ("ta", "Tamil", #imageLiteral(resourceName: "india"), "india.png"),
        ("te", "Telugu", #imageLiteral(resourceName: "india"), "india.png"),
        ("th", "Thai", #imageLiteral(resourceName: "thailand"), "thailand.png"),
        ("tr", "Turkish", #imageLiteral(resourceName: "turkey"), "turkey.png"),
        ("uk", "Ukrainian", #imageLiteral(resourceName: "ukraine"), "ukraine.png"),
        ("ur", "Urdu", #imageLiteral(resourceName: "pakistan"), "pakistan.png"),
        ("uz", "Uzbek", #imageLiteral(resourceName: "uzbekistn"), "uzbekistn.png"),
        ("vi", "Vietnamese", #imageLiteral(resourceName: "vietnam"), "vietnam.png"),
        ("cy", "Welsh", #imageLiteral(resourceName: "wales"), "wales.png"),
        ("xh", "Xhosa", #imageLiteral(resourceName: "south-africa"), "south-africa.png"),
        ("yi", "Yiddish", #imageLiteral(resourceName: "israel"), "israel.png"),
        ("yo", "Yoruba", #imageLiteral(resourceName: "nigeria"), "nigeria.png"),
        ("zu", "Zulu", #imageLiteral(resourceName: "south-africa"), "south-africa.png")
        ].sorted(by: {$0.1 < $1.1})
}
