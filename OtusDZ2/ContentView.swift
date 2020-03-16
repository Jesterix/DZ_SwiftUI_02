//
//  ContentView.swift
//  OtusDZ2
//
//  Created by Георгий Хайденко on 16.03.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    var news = ["news", "contacts", "weather"]

    var body: some View {
        VStack{
            Picker(selection: $selection, label: Text("News") ) {
                ForEach(0..<news.count) { index in
                    Text(self.news[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Text("Value: \(news[selection])")
            Spacer()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
