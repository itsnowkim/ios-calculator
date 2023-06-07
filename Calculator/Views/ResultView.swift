//
//  ResultScreen.swift
//  Calculator
//
//  Created by Now Kim on 2023/06/05.
//

import SwiftUI

struct ResultView: View {
    @Binding var valueData: ValueData
    
    var body: some View {
        Text("\(valueData.presentValue)")
            .foregroundColor(.white)
            .font(.system(size:70))
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(valueData: .constant(.init()))
    }
}
