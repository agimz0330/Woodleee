//
//  WinLoseView.swift
//  Woodleee
//
//  Created by User23 on 2022/4/15.
//

import SwiftUI

struct WinLoseView: View {
    @Binding var isWin: Bool
    @Binding var isLose: Bool
    @Binding var ansSinger: String
    
    @State private var moveDistance: CGFloat = 100
    @State private var opacity: Double = 0
    @State private var rotateDegree: Double = 0
    
    var body: some View {
        let fontColor = Color(red: 105/250, green: 147/250, blue: 169/250) // 藍色字體
        
        VStack{
            if isWin{
                VStack(alignment: .trailing){
                    Text("You WIN!")
                        .font((.custom("ValentineFantasy", size: 35)))
                        .foregroundColor(.purple)
                        .background(
                            Rectangle()
                                .frame(width: 800)
                                .border(Color.white, width: 20)
                                .foregroundColor(Color.white)
                                .opacity(0.4))
                    Text("答案是 \"\(ansSinger)\"")
                        .foregroundColor(.black)
                }
                .offset(x: moveDistance)
                .opacity(opacity)
                .rotationEffect(.degrees(rotateDegree))
                .animation(.easeIn, value: moveDistance)
                .animation(.easeIn, value: opacity)
                .onAppear{
                    moveDistance -= 100
                    opacity = 1
                    rotateDegree -= 360
                }
            }
            else if isLose{
                VStack(alignment: .trailing){
                    Text("You Lose...")
                        .font((.custom("ValentineFantasy", size: 35)))
                        .foregroundColor(.pink)
                        .background(
                            Rectangle()
                                .frame(width: 800)
                                .border(Color.white, width: 20)
                                .foregroundColor(Color.white)
                                .opacity(0.4))
                    Text("答案是 \"\(ansSinger)\"")
                        .foregroundColor(.black)
                }
                .offset(x: moveDistance)
                .opacity(opacity)
                .rotationEffect(.degrees(rotateDegree))
                .animation(.easeIn, value: moveDistance)
                .animation(.easeIn, value: opacity)
                .onAppear{
                    moveDistance -= 100
                    opacity = 1
                    rotateDegree += 360
                }
            }
            else{
                Spacer()
            }
        }
    }
}
