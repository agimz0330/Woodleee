//
//  LetterKey.swift
//  Woodleee
//
//  Created by User23 on 2022/4/8.
//

import Foundation
struct KeyRecord{
    var keyFunc: KeyFunc = .type // 預設為字母(宣告時要改)
    var keyState: KeyState = .unuse // 一開始都是未使用
}

enum KeyFunc{
    case type, backspace, enter, clear
}

enum KeyState{
    case unuse, wrong, half_correct, correct
    // 未使用 white, 不在單詞中 gray, 錯的位置 yellow, 全對 green
}

let boards: [String] = ["ㄅㄉ ㄓ ㄚㄞㄢㄦ",
                      "ㄆㄊㄍㄐㄔㄗㄧㄛㄟㄣ",
                      "ㄇㄋㄎㄑㄕㄘㄨㄜㄠㄤ",
                      "ㄈㄌㄏㄒㄖㄙㄩㄝㄡㄥ"]

func initKeyboard() -> [Character: KeyState]{
    var keyboard: [Character: KeyState] = [:]
    
    for board in boards{
        for c in board{
            if c != " "{
                keyboard[c] = KeyState.unuse
            }
        }
    }
    return keyboard
}
