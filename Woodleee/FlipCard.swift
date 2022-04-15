//
//  FlipCard.swift
//  Woodleee
//
//  Created by User23 on 2022/4/12.
//

import SwiftUI

struct FlipCard: View {
    @State private var degrees1 = 0.0
    @State private var degrees2 = 0.0
    
    @State var isFlipped: Bool = false // in letter attribute
    @Binding var letter: Letter
    
    func flipCard(){
        withAnimation(Animation.linear(duration: 0.4)){
            degrees1 += 180
        }
        withAnimation(Animation.linear(duration: 0.4)){
            degrees2 -= 180
            isFlipped.toggle()
        }
    }
    
    var body: some View {
        ZStack{
            if isFlipped{
                UsedCardView(letter: letter)
            }
            else{
                UnesedCardView(letter: letter)
            }
        }
        .rotation3DEffect(.degrees(degrees1), axis: (x: 1.0, y: 0.0, z: 0.0))
        .onChange(of: letter.isFlipped, perform: { _ in
            flipCard()
        })
        .rotation3DEffect(.degrees(degrees2), axis: (x: 1.0, y: 0.0, z: 0.0))
        
    }
}


struct UnesedCardView: View {
    var letter: Letter
    
    var body: some View{
        let whiteColor = Color(red: 234/250, green: 231/250, blue: 222/250, opacity: 0.25)
        let fontColor = Color(red: 105/250, green: 147/250, blue: 169/250) // 藍色字體
        
        // 未翻牌
        Rectangle()
            .frame(width: 40, height: 40)
            .foregroundColor(whiteColor)
            .border(fontColor, width: 2)
            .overlay(Text("\(letter.letter)")
                        .font(.title)
                        .fontWeight(.bold)
                     )
            
            
    }
}

struct UsedCardView: View {
    var letter: Letter
    
    var body: some View{
        let gridColor = Color(red: 173/250, green: 202/250, blue: 210/250) // 淺灰,還沒猜過的格子
        let yellowColor = Color(red: 230/250, green: 200/250, blue: 20/250)
        let greenColor = Color(red: 20/250, green: 200/250, blue: 70/250)
        
        // 已翻牌
        if letter.keyState == KeyState.wrong{
            Rectangle()
                .frame(width: 40, height: 40)
                .foregroundColor(gridColor)
                .overlay(Text("\(letter.letter)")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                         )
        }
        else if letter.keyState == KeyState.half_correct{
            Rectangle()
                .frame(width: 40, height: 40)
                .foregroundColor(yellowColor)
                .overlay(Text("\(letter.letter)")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                         )
        }
        else if letter.keyState == KeyState.correct{
            Rectangle()
                .frame(width: 40, height: 40)
                .foregroundColor(greenColor)
                .overlay(Text("\(letter.letter)")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                         )
        }
    }
}

struct CardView: View {
    @Binding var word: Word
    
    var body: some View{
        let fontColor = Color(red: 105/250, green: 147/250, blue: 169/250) // 藍色字體
        
        HStack(alignment: .bottom){
            ForEach(0..<word.word.count, id: \.self){ index in
                if word.word[index].keyState == .unuse{
                    UnesedCardView(letter: word.word[index])
                }
                else{
                    FlipCard(letter: $word.word[index]) // word.word[index]: Letter
                }
            }
            Text(" \(word.singersName)")
                .foregroundColor(fontColor)
                .font(.footnote)
        }
    }
}

