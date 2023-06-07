//
//  ValueData.swift
//  Calculator
//
//  Created by Now Kim on 2023/06/06.
//

import Foundation

/// presentValue : 화면에 보이는 문자열
/// firstValue, secondValue : 계산하기 위한 두 개의 문자열
/// symbol : 연산자
struct ValueData{
    var presentValue: String
    var firstValue: String
    var pressedOperand:Bool
    var symbol: ButtonType
    
    // 초기화자 (initializer) 선언
    init() {
        self.presentValue = "0"
        self.firstValue = ""
        self.pressedOperand = true
        self.symbol = ButtonType.equation
    }
}

