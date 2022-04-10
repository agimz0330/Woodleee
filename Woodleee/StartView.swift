//
//  StartView.swift
//  Woodleee
//
//  Created by User23 on 2022/4/10.
//

import SwiftUI

struct StartView: View {
    @State var strData: String = "Hello world!"
    @State var dataCount: Int = 0
    
    func getDataset(){
        if let asset = NSDataAsset(name: "Two Letter"), // 從asset讀取檔案
           let content = String(data: asset.data, encoding: .utf8){ // 將檔案以utf8轉成String
            let dataList = content.split(separator: "\r\n") // 用換行分割成[Substring]陣列
            
            var letterList: [String] = [] // 儲存注音
            var singerList: [String] = [] // 儲存歌手全名
            
            dataCount = dataList.count
            
            for data in dataList{ // 每一行
                let dataStr = String(data) // 把Substring轉成String
                let dataaa = dataStr.split(separator: " ") // 每一行本來是“注音 歌手全名”以空格分開
                letterList.append(String(dataaa[0])) // [0]：注音，Substring轉成string存進陣列
                singerList.append(String(dataaa[1])) // [1]：歌手全名
            }
            
            strData = singerList.joined()
        }
    }
    var body: some View {
        VStack{
            Button(action: {
                getDataset()
            }, label: {
                Text("Button")
            })
            Text("\(dataCount)")
            Text("\(strData)")
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
