//
//  Languages.swift
//  iBase
//
//  Created by Numan Ayhan on 26.07.2021.
//

import Foundation
import UIKit

enum Languages : String {
    case english = "English";
    case turkish = "Türkçe";
    case german = "German (Deutsche)";
    
}

extension String {
    
    func localized(comment: String  = "" ) ->String {
          
        return  NSLocalizedString(self ,tableName: nil, bundle: Bundle.main, value: "",  comment: comment)
    }
}

enum Language: Equatable {
    case english(English)
    case chinese(Chinese)
    case korean
    case japanese
    case turkish
    
    enum English {
        case us
        case uk
        case australian
        case canadian
        case indian
    }

    enum Chinese {
        case simplified
        case traditional
        case hongKong
    }
    
}

extension Language {

    var code: String {
        switch self {
        case .english(let english):
            switch english {
            case .us:                return "en"
            case .uk:                return "en-GB"
            case .australian:        return "en-AUD"
            case .canadian:          return "en-CA"
            case .indian:            return "en-IN"
        }

        case .chinese(let chinese):
            switch chinese {
            case .simplified:       return "zh-Hans"
            case .traditional:      return "zh-Hant"
            case .hongKong:         return "zh-HK"
        }
            case .korean:           return "ko"
            case .japanese:         return "ja"
            case .turkish:          return "tr"
        }
        
    }

    var name: String {
        switch self {
        case .english(let english):
            switch english {
            case .us:                return "English"
            case .uk:                return "English (UK)"
            case .australian:        return "English (Australia)"
            case .canadian:          return "English (Canada)"
            case .indian:            return "English (India)"
            }

        case .chinese(let chinese):
            switch chinese {
            case .simplified:       return "简体中文"
            case .traditional:      return "繁體中文"
            case .hongKong:         return "繁體中文 (香港)"
            }

        case .korean:               return "한국어"
        case .japanese:             return "日本語"
        case .turkish:              return "Türkçe"
        }
    }
}

extension Language {

    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        switch languageCode {
        case "en", "en-US":     self = .english(.us)
        case "en-GB":           self = .english(.uk)
        case "en-AU":           self = .english(.australian)
        case "en-CA":           self = .english(.canadian)
        case "en-IN":           self = .english(.indian)

        case "zh-Hans":         self = .chinese(.simplified)
        case "zh-Hant":         self = .chinese(.traditional)
        case "zh-HK":           self = .chinese(.hongKong)

        case "ko":              self = .korean
        case "ja":              self = .japanese
        default:                return nil
        }
    }
}
