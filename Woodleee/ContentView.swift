//
//  ContentView.swift
//  Woodleee
//
//  Created by User23 on 2022/4/1.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: Wordle = Wordle()
    @State private var showGuideView = false
    @State private var showHint = false
    
    var body: some View {
        let bgBlueColor = Color(red: 145/250, green: 225/250, blue: 245/250) // 背景
        let bgGreenColor = Color(red: 179/250, green: 220/250, blue: 30/250) // 背景
        let fontColor = Color(red: 105/250, green: 147/250, blue: 169/250) // 藍色字體
        
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
                        .foregroundColor(fontColor)
                    Text("W O R D L E")
                        .font(.custom("Planks", size: 40))
                        .foregroundColor(fontColor)
                        .offset(x: 1, y: 1)
                }
                
                HStack{
                    Text("\(Int(game.wordCount)) letters")
                        .foregroundColor(fontColor)
                    Slider(value: $game.wordCount, in: 2...5, step: 1) // 調整字數
                        .accentColor(.white)
                        .onChange(of: game.wordCount, perform: { _ in
                            game.updateWordCount()
                        })
                        .disabled(game.disableSlider())
                    
                    Button(action: {
                        showGuideView = true
                    }, label: {
                        Text(Image(systemName: "questionmark"))
                            .foregroundColor(fontColor)
                            .bold()
                            .font(.title)
                    })
                    Button(action: {
                        
                    }, label: {
                        Text(Image(systemName: "books.vertical"))
                            .foregroundColor(fontColor)
                            .bold()
                            .font(.headline)
                    })
                    Button(action: {
                        showHint = true
                    }, label: {
                        Text(Image(systemName: "lightbulb"))
                            .foregroundColor(fontColor)
                            .bold()
                            .font(.title2)
                    })
                }
                .padding([.leading, .trailing], 50) // 左右空位子
                
                VStack(alignment: .leading){ // 靠左對齊
                    ForEach(0..<Int(game.guessTimes), id: \.self){ i in
                        CardView(word: $game.words[i])
                    }
                }
                
                if showHint{
                    Text("\(game.hintStr)")
                        .foregroundColor(fontColor)
                        .bold()
                        .offset(x: 100)
                }
                
                WinLoseView(isWin: $game.isWin, isLose: $game.isLose, ansSinger: $game.ansSinger)
                
                KeyboardView(game: game)
                
            }
        }
        .alert(isPresented: $game.showAlert){ () -> Alert in
            return Alert(title: Text("\(game.alertTitle)"))
        }
        .onAppear{
            game.initialGame()
        }
        .fullScreenCover(isPresented: $showGuideView, content: {
            GuideView(showGuideView: $showGuideView)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
