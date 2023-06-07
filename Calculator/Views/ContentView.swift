//
//  ContentView.swift
//  Calculator
//
//  Created by Now Kim on 2023/06/05.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0
    @State var valueData = ValueData()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ResultView(valueData:$valueData)
                        .padding()
                }
                ButtonView(valueData:$valueData)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
