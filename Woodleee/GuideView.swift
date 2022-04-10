//
//  GuideView.swift
//  Woodleee
//
//  Created by User23 on 2022/4/1.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        let titleColor = Color(red: 173/250, green: 202/250, blue: 210/250) // 淺藍
        let gridColor = Color(red: 150/250, green: 150/250, blue: 150/250)
        
        ZStack{
            Color.gray // 背景顏色
                .edgesIgnoringSafeArea(.all) // 全螢幕
            
            VStack(alignment: .leading){
                Text("")
                Divider()
                    .foregroundColor(.white)
                
            }
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GuideView()
        }
    }
}
