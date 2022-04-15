//
//  Letter.swift
//  Woodleee
//
//  Created by User23 on 2022/4/11.
//

import Foundation

struct Letter: Identifiable {
    let id = UUID()
    var letter: String = " "
    var keyState: KeyState = .unuse
    var isFlipped: Bool = false
}

struct Word {
    var word: [Letter] = Array(repeating: Letter(), count: 3) // 一個詞預設3個字
    var singersName: String = ""
}

// Example Word use for Guide View
let exWord1: Word = Word(word: [ Letter(letter: "ㄓ", keyState: .unuse, isFlipped: false), // example word 1
                                  Letter(letter: "ㄏ", keyState: .correct, isFlipped: false),
                                  Letter(letter: "ㄇ", keyState: .unuse, isFlipped: false)],
                         singersName: "(張惠妹)")
let exWord2: Word = Word(word: [ Letter(letter: "ㄉ", keyState: .unuse, isFlipped: false), // example word 2
                                  Letter(letter: "ㄗ", keyState: .unuse, isFlipped: false),
                                  Letter(letter: "ㄑ", keyState: .half_correct, isFlipped: false)],
                         singersName: "(鄧紫棋)")
let exWord3: Word = Word(word: [ Letter(letter: "ㄘ", keyState: .wrong, isFlipped: false), // example word 3
                                  Letter(letter: "ㄧ", keyState: .unuse, isFlipped: false),
                                  Letter(letter: "ㄌ", keyState: .unuse, isFlipped: false)],
                         singersName: "(蔡依林)") 

func getWordStr(word: Word) -> String{ // return "ㄓㄏㄇ"
    var result = ""
    for letter in word.word{
        result += letter.letter
    }
    return result
}
