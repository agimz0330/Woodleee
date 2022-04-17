//
//  KeyboardView.swift
//  Woodleee
//
//  Created by User23 on 2022/4/12.
//

import SwiftUI

struct KeyboardView: View { // 最下方的鍵盤
    @ObservedObject var game: Wordle
    // keyboard: [Character: KeyState]
    
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
                                game.keyTypeIn(letter: String(boardList[i])) // boardList[i]: Substring
                            }, label: {
                                if game.keyboard[letter] == KeyState.unuse{
                                    letterView(useColor: whiteColor, letterText: boardList[i])
                                }
                                else if game.keyboard[letter] == KeyState.wrong{
                                    letterView(useColor: grayColor, letterText: boardList[i])
                                }
                                else if game.keyboard[letter] == KeyState.half_correct{
                                    letterView(useColor: yellowColor, letterText: boardList[i])
                                }
                                else { // correct
                                    letterView(useColor: greenColor, letterText: boardList[i])
                                }
                            })
                            .disabled(game.disableInput())
                        }
                        
                    } // ForEach End.
                    
                    if index == 0{
                        Button(action: {
                            game.keyBackSpace()
                        }, label: { // back Space <-
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
                        Button(action: {
                            game.keyClear()
                        }, label: { // clear
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
                            game.keyEnter()
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
                        .disabled(game.disableInput())
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
