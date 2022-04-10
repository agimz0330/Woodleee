//
//  ContentView.swift
//  Woodleee
//
//  Created by User23 on 2022/4/1.
//

import SwiftUI

struct ContentView: View {
    @State private var wordCount: Double = 3 // 猜一次有幾個字
    @State private var keyboard: [Character: KeyState] = initKeyboard() // 鍵盤[注音: (未使用，不正確...)]
    @State private var tempStr: String = " "
    
    func UpdateWordCount(){
        
    }
    
    var body: some View {
        let bgBlueColor = Color(red: 145/250, green: 225/250, blue: 245/250) // 背景
        let bgGreenColor = Color(red: 179/250, green: 220/250, blue: 30/250) // 背景
        let gridColor = Color(red: 173/250, green: 202/250, blue: 210/250) // 淺藍,還沒猜過的格子
        let blueColor = Color(red: 105/250, green: 147/250, blue: 169/250) // 藍色字體
        let guessTimes: Int = 7 // 可猜７次
        
        ZStack{
            VStack{
                bgBlueColor // 背景顏色
                    .edgesIgnoringSafeArea(.all) // 全螢幕
                bgGreenColor
                    .edgesIgnoringSafeArea(.all)
            }
            Image("grass") // 背景圖片
                .resizable()
                .scaledToFit()
            
            VStack{
                ZStack{ // title: Wordle
                    Text("W O R D L E")
                        .font(.custom("Planks", size: 40))
                        .foregroundColor(blueColor)
                    Text("W O R D L E")
                        .font(.custom("Planks", size: 40))
                        .foregroundColor(blueColor)
                        .offset(x: 1, y: 1)
                }
                
                HStack{ // 調整字數
                    Text("\(Int(wordCount)) letters")
                        .foregroundColor(blueColor)
                    Slider(value: $wordCount, in: 2...5, step: 1)
                        .accentColor(.white)
                        .onChange(of: wordCount, perform: { value in
                            UpdateWordCount()
                        })
                }
                .padding([.leading, .trailing], 50) // 左右空位子
                
                VStack(alignment: .leading){ // 靠左對齊
                    // result
                    ForEach(0..<guessTimes){ guessTime in
                        HStack{
                            // 格子
                            Rectangle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(gridColor)
                            Rectangle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(gridColor)
                            Rectangle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(gridColor)
                            Text("\(tempStr)")
                                .foregroundColor(blueColor)
                            // 說明
                        }
                    }
                }
                
                Spacer()
                
                // input
                keyBoardView(keyboard: $keyboard, tempStr: $tempStr)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct keyBoardView: View { // 最下方的鍵盤
    @Binding var keyboard: [Character: KeyState]
    @Binding var tempStr: String
    
    func keyTypeIn(letter: String){
        tempStr = tempStr + letter
    }
    
    var body: some View{
        let whiteColor = Color(red: 234/250, green: 231/250, blue: 222/250, opacity: 0.25)
        let grayColor = Color(red: 171/250, green: 163/250, blue: 145/250)
        let yellowColor = Color(red: 230/250, green: 200/250, blue: 20/250)
        let greenColor = Color(red: 20/250, green: 200/250, blue: 70/250)
        
        VStack{
            ForEach(boards.indices){index in
                let board = boards[index]
                
                HStack{
                    let boardList = board.map{ String($0) } // String to Array
                    ForEach(boardList.indices){ i in
                        let letter = Character(boardList[i])
                        if letter == " "{
                            Spacer()
                        }
                        else{
                            Button(action: {
                                keyTypeIn(letter: boardList[i])
                            }, label: {
                                if keyboard[letter] == KeyState.unuse{
                                    letterView(useColor: whiteColor, letterText: boardList[i])
                                }
                                else if keyboard[letter] == KeyState.wrong{
                                    letterView(useColor: grayColor, letterText: boardList[i])
                                }
                                else if keyboard[letter] == KeyState.half_correct{
                                    letterView(useColor: yellowColor, letterText: boardList[i])
                                }
                                else { // correct
                                    letterView(useColor: greenColor, letterText: boardList[i])
                                }
                            })
                        }
                        
                    } // ForEach End.
                    
                    if index == 0{
                        Button(action: {}, label: { // back Space <-
                            Rectangle()
                                .frame(width: 50, height: 35)
                                .foregroundColor(whiteColor)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .overlay(
                                    Image(systemName: "arrow.left")
                                    .foregroundColor(.white)
                                )
                        })
                    }
                    else if index == 1{
                        Button(action: {}, label: { // clear
                            Rectangle()
                                .frame(width: 35, height: 35)
                                .foregroundColor(whiteColor)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .overlay(
                                    Image(systemName: "x.circle.fill")
                                    .foregroundColor(.white)
                                )
                        })
                    }
                    else if index == 2{
                        Button(action: {
                        }, label: { // Enter
                            Rectangle()
                                .frame(width: 35, height: 35)
                                .foregroundColor(whiteColor)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .overlay(
                                    Image(systemName: "arrow.turn.down.left")
                                    .foregroundColor(.white)
                                )
                        })
                    }
                }
            } // ForEach End.
                
        } // VStack End.
        
    }
}

struct letterView: View{ // 每個鍵
    var useColor: Color
    var letterText: String
    
    var body: some View{
        Group{
            Rectangle()
                .frame(width: 25, height: 35)
                .foregroundColor(useColor)
                .cornerRadius(10)
                .shadow(radius: 5)
                .overlay(Text("\(letterText)")
                            .foregroundColor(.white)
                            .bold()
                )
        }
    }
    
}
