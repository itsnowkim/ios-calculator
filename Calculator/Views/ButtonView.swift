//
//  ButtonView.swift
//  Calculator
//
//  Created by Now Kim on 2023/06/05.
//

import SwiftUI

enum ButtonType: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case dot = "."
    case clear = "AC"
    case oposite = "+/-"
    case percent = "%"
    case divide = "÷"
    case multiply = "×"
    case minus = "-"
    case plus = "+"
    case equation = "="
    case none = ""
}

func isNumber(ele:ButtonType) -> Bool {
    let numbers = [ButtonType.zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot]
    
    if numbers.contains(ele){
        return true
    }
    return false
}

func calculateResult(x: String, y: String, operand: ButtonType) -> String{
    // type casting
    let var1 = Float(x)!
    let var2 = Float(y)!
    
    // 계산하기
    var result:Float
    
    switch operand {
    case ButtonType.percent:
        result = var1.truncatingRemainder(dividingBy: var2)
    case ButtonType.multiply:
        result = var1 * var2
    case ButtonType.minus:
        result = var1 - var2
    case ButtonType.plus:
        result = var1 + var2
    case ButtonType.divide:
        result = var1 / var2
    default:
        result = 0
    }
    
    // 소수점 처리
    if result == Float(Int(result)){
        return String(Int(result))
    }
    return String(result)
}

func toggleValue(x:String) -> String{
    if x == "0"{
        return "0"
    }
    
    // convert string to numeric
    var var1 = Float(x)!
    var1 *= -1
    
    // 소수점 처리
    if var1 == Float(Int(var1)){
        return String(Int(var1))
    }
    return String(var1)
}

func canCalculate(var1:String, var2:String) -> Bool {
    if var1 != "" && var2 != ""{
        return true
    }
    return false
}

struct ButtonView: View {
    @Binding var valueData: ValueData
    
    let rows:[[ButtonType]] = [
        [.clear, .oposite, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equation],
    ]
    @State var clearScreen = false
    
    func initiate(flag:Bool) -> Void{
        valueData.firstValue = ""
        valueData.pressedOperand = true
        valueData.symbol=ButtonType.none
        if flag{
            valueData.presentValue="0"
        }
    }
    
    var body: some View {
        VStack {
            ForEach(rows, id: \.self) { row in
                HStack {
                    ForEach(Array(row.enumerated()), id: \.1) { index, element in
                        Button {
                            switch element{
                            case ButtonType.equation:
                                if canCalculate(var1: valueData.firstValue, var2: valueData.presentValue){
                                    // firstValue + secondValue + symbol.
                                    let calculated = calculateResult(x: valueData.firstValue, y: valueData.presentValue, operand: valueData.symbol)
                                    valueData.presentValue = calculated
                                    
                                    // init
                                    initiate(flag:false)
                                }
                            case ButtonType.clear:
                                initiate(flag: true)
                                
                            case ButtonType.oposite:
                                let calculated = toggleValue(x: valueData.presentValue)
                                valueData.presentValue = calculated
                                
                            default:
                                if isNumber(ele: element){
                                    valueData.pressedOperand = false
                                    if clearScreen == true{
                                        valueData.presentValue = element.rawValue
                                        clearScreen.toggle()
                                    }
                                    else{
                                        // 숫자 -> presentValue update
                                        if valueData.presentValue == "0"{
                                            valueData.presentValue = element.rawValue
                                        }else{
                                            valueData.presentValue += element.rawValue
                                        }
                                    }
                                }else{
                                    // 계산이 가능하면 계산 후 해당 값으로 present 업데이트
                                    if canCalculate(var1: valueData.firstValue, var2: valueData.presentValue) && !valueData.pressedOperand{
                                        let calculated = calculateResult(x: valueData.firstValue, y: valueData.presentValue, operand: valueData.symbol)
                                        valueData.presentValue = calculated
                                        valueData.symbol = element
                                        valueData.firstValue = calculated
                                    }else{
                                        // 연산을 할 수 없는 경우.
                                        valueData.symbol = element
                                        valueData.firstValue = valueData.presentValue
                                    }
                                    
                                    valueData.pressedOperand = true
                                    if !clearScreen{
                                        clearScreen.toggle()
                                    }
                                }
                            }
                        }label:{
                            Text(element.rawValue)
                                .frame(width: element == .zero ? 185 : 90, height: 90)
                                .background(index == row.count - 1 ? Color.orange : Color.gray)
                                .cornerRadius(45)
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                        }
                    }
                }
                
            }
        }
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(valueData: .constant(.init()))
    }
}
