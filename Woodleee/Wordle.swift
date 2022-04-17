//
//  Wordle.swift
//  Woodleee
//
//  Created by User23 on 2022/4/12.
//

import Foundation
import SwiftUI

class Wordle: ObservableObject{
    @Published var words: [Word] = Array(repeating: Word(), count: 7)
    @Published var keyboard: [Character: KeyState] = initKeyboard() // 鍵盤[注音: (未使用，不正確...)]
    @Published var wordCount: Double = 3 // 可用slider 調整字數
    @Published var isWin: Bool = false
    @Published var isLose: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    
    let guessTimes: Int = 7 // 可猜幾次
    var nowWordIndex: Int = 0 // 目前在猜第幾次
    var nowLetterIndex: Int = 0 // 目前在輸入第幾個字
    
    var letterList: [String] = [] // 儲存注音
    var singerList: [String] = [] // 儲存歌手全名
    var ansIndex: Int = 0
    var hintStr: String = ""
    var ansSinger: String = "?"
    
    func initialGame() {
        words = Array(repeating: Word(), count: guessTimes)
        keyboard = initKeyboard()
        nowWordIndex = 0
        nowLetterIndex = 0
        getDataset()
    }
    
    func getDataset(){
        let dataName = [2: "Two Letter", 3: "Three Letter", 4: "Four Letter", 5: "Five Letter"]
        
        if let asset = NSDataAsset(name: dataName[Int(wordCount)]!), // 從asset讀取檔案
           let content = String(data: asset.data, encoding: .utf8){ // 將檔案以utf8轉成String
            
            let dataList = content.split(separator: "\r\n") // 用換行分割成[Substring]陣列
            let dataCount: Int = dataList.count
            
            letterList = [] // 先清除原資料
            singerList = []
            ansIndex = Int.random(in: 0..<dataCount)
            
            for data in dataList{ // 每一行
                let dataStr = String(data) // 把Substring轉成String
                let dataaa = dataStr.split(separator: " ") // 每一行本來是“注音 歌手全名”以空格分開
                letterList.append(String(dataaa[0])) // [0]：注音，Substring轉成string存進陣列
                singerList.append(String(dataaa[1])) // [1]：歌手全名
            }
        }
        let firstLetter = singerList[ansIndex][singerList[ansIndex].startIndex]
        hintStr = "第一個字是 " + String(firstLetter)
        ansSinger = singerList[ansIndex]
        print(letterList[ansIndex] + " " + singerList[ansIndex])
    }
    
    func updateWordCount(){ // when slider on change
        // modify data length
        words = Array(repeating: Word(word: Array(repeating: Letter(),
                                                  count: Int(wordCount))),
                      count: guessTimes)
        // set ans & data by wordcount
        getDataset()
    }
    
    func disableSlider() -> Bool { // game has started
        if nowWordIndex != 0 || nowLetterIndex != 0{ // 有輸入或有猜過
            return true // cant slide
        }
        // can change wordCount
        return false
    }
    
    func disableInput() -> Bool{
        return isWin || isLose
    }
    
    func keyTypeIn(letter: String) {
        if nowLetterIndex < Int(wordCount){
            // change letter text in word
            words[nowWordIndex].word[nowLetterIndex].letter = letter
            nowLetterIndex += 1
        }
    }
    
    func keyBackSpace(){
        if nowLetterIndex > 0{
            nowLetterIndex -= 1
            words[nowWordIndex].word[nowLetterIndex].letter = " "
        }
    }
    func keyClear(){
        // set current word's all letter = " "
        for i in 0..<nowLetterIndex{
            words[nowWordIndex].word[i].letter = " "
        }
        nowLetterIndex = 0
    }
    func keyEnter(){
        if nowLetterIndex != Int(wordCount){ // 格子沒填滿
            showAlert = true
            alertTitle = "字數不足"
        }
        
        else{
            let nowWordStr = getWordStr(word: words[nowWordIndex])
            let dataCount: Int = letterList.count
            var validWord: Bool = false
            
            for index in 0..<dataCount{
                if nowWordStr == letterList[index]{ // if word in dataset
                    words[nowWordIndex].singersName += " " + singerList[index]
                    validWord = true
                }
            }
            
            if validWord{
                for i in nowWordStr.indices{
                    let nowIndex: Int = nowWordStr.distance(from: nowWordStr.startIndex, to: i)
                    if nowWordStr[i] == letterList[ansIndex][i]{
                        keyboard[nowWordStr[i]] = .correct
                        words[nowWordIndex].word[nowIndex].keyState = .correct
                    }
                    else if letterList[ansIndex].contains(nowWordStr[i]){
                        if keyboard[nowWordStr[i]] != .correct {
                            keyboard[nowWordStr[i]] = .half_correct
                        }
                        words[nowWordIndex].word[nowIndex].keyState = .half_correct
                    }
                    else{
                        if keyboard[nowWordStr[i]] != .correct || keyboard[nowWordStr[i]] != .half_correct{
                            keyboard[nowWordStr[i]] = .wrong
                        }
                        words[nowWordIndex].word[nowIndex].keyState = .wrong
                    }
                }
                
                nowWordIndex += 1
                nowLetterIndex = 0
                
                if nowWordStr == letterList[ansIndex]{ // win
                    print("win")
                    // show win & answer
                    isWin = true
                    // update statistics record
                }
                else if nowWordIndex == guessTimes{ // lose
                    print("lose")
                    isLose = true
                    // show lose & answer
                    // update statistics record
                }
                
                for ii in 0..<Int(wordCount){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 * Double(ii+1)){
                        self.words[self.nowWordIndex - 1].word[ii].isFlipped.toggle()
                    }
                }
            }
            else{
                showAlert = true
                alertTitle = "沒有這個歌手或樂團！"
            }
        }
    }
}
