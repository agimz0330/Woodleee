//
//  GuideView.swift
//  Woodleee
//
//  Created by User23 on 2022/4/1.
//

import SwiftUI

struct GuideView: View {
    @Binding var showGuideView: Bool
    @State var exWord_One: Word = exWord1
    @State var exWord_Two: Word = exWord2
    @State var exWord_Three: Word = exWord3
    
    var body: some View {
        let bgYellowColor = Color(red: 245/255, green: 243/255, blue: 231/255) // 背景
        
        ZStack{
            bgYellowColor // 背景顏色
                .edgesIgnoringSafeArea(.all) // 全螢幕
            
            VStack(alignment: .leading, spacing: 10){
                Button(action: {
                    showGuideView = false // 返回遊戲頁面
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 20, height: 25)
                        .accentColor(.gray)
                })
                
                Spacer()
                
                Group{
                    Text("這是一個注音版的 Wordle !")
                    Text("答案是華語歌手或團體，可以選擇要猜2~5個字的名字，每格輸入該字的第一個注音。")
                    Text("每次按下 Enter 提交答案後，方格會變成不同的顏色，作為下一輪的提示。")
                }
                Divider()
                
                Group{
                    Text("例子")
                        .bold()
                    CardView(word: $exWord_One)
                    Text("答案裡面有ㄏ這個注音，而且位置正確。\n")
                    CardView(word: $exWord_Two)
                    Text("答案裡有ㄑ這個注音，但是位置不對。\n")
                    CardView(word: $exWord_Three)
                    Text("答案裡沒有ㄘ。\n")
                }
                
                Divider()
                Group{
                    Text("ＮＯＴＥ")
                        .bold()
                    Text("只有７次機會，按下Enter提交答案後不能再調整字數。")
                    Text("\n\tＦＩＧＨＴＩＮＧ ;)")
                }
            
            }
            .padding()
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){ // wait 1 second
                exWord_One.word[1].isFlipped.toggle()
                exWord_Two.word[2].isFlipped.toggle()
                exWord_Three.word[0].isFlipped.toggle()
            }
        }
    }
}

