//
//  word.swift
//  VocabularyApp(SwiftUI)
//
//  Created by Jun on 1/2/25.
//

import Foundation

struct Word: Decodable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetics]?
    let origin: String?
    let meanings: [Meanings]? 
    
    struct Phonetics: Decodable {
        let texts: [Text]?
    }
    
    struct Text: Decodable {
        let text: String?
        let audio: String?
    }
    
    struct Meanings: Decodable {
//        let partOfSpeeches: [PartOfSpeeches]?
        let partOfSpeech: String?
        let definitions: [Definitions]?
        let synonyms: [String]?
        let antonyms: [String]?
    }
    
//    struct PartOfSpeeches: Decodable {
//        let partOfSpeech: String?
//        let definitions: [Definitions]?
//    }
    
    struct Definitions: Decodable {
//        var id: String?
        let definition: String?
        let example: String?
        let synonyms: [String]?
        let antonyms: [String]?
    }
    
//    struct Synonyms: Decodable {
//        let synonym: [String]?
//    }
    
//    struct Antonyms: Decodable {
//        let antonym: String?
//    }
}
