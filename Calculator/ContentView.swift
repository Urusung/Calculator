//
//  ContentView.swift
//  Calculator
//
//  Created by Chois-mac on 2022/11/17.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var operatorType: ButtonType = .clear
    @State var isNotEditing: Bool = true
    
    enum ButtonType{
        case one, two, three, four, five, six, seven, eight, nine, zero
        case comma, equal, plus, minus, multiple, devide
        case percent, opposite, clear
        
        var buttonDisplayName: String {
            switch self {
            case .one : return "1"
            case .two : return "2"
            case .three : return "3"
            case .four : return "4"
            case .five : return "5"
            case .six : return "6"
            case .seven : return "7"
            case .eight : return "8"
            case .nine : return "9"
            case .zero : return "0"
            case .comma : return "."
            case .equal : return "="
            case .plus : return "+"
            case .minus : return "-"
            case .multiple : return "×"
            case .devide : return "÷"
            case .percent : return "%"
            case .opposite : return "+/-"
            case .clear : return "AC"
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .comma:
                return Color("NumberButton")
                
            case .equal, .plus, .minus, .multiple, .devide:
                return .orange
                
            case .percent, .opposite, .clear:
                return Color("SignButton")
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .comma, .equal, .plus, .minus, .multiple, .devide:
                return .white
                
            case .percent, .opposite, .clear:
                return .black
                
            }
        }
    }
    
    private let buttonData: [[ButtonType]] = [
        [.clear,.opposite,.percent,.devide],
        [.seven,.eight,.nine,.multiple],
        [.four,.five,.six,.minus],
        [.one,.two,.three,.plus],
        [.zero,.comma,.equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(totalNumber).foregroundColor(.white).padding().font(.system(size: 82, weight: .thin))
                }
                
                ForEach(buttonData, id: \.self) { line in
                    HStack {
                        ForEach(line, id: \.self) {
                            item in
                            
                            Button {
                                if(isNotEditing) {
                                    if(item == .clear) {
                                        totalNumber = "0"
                                        isNotEditing = true
                                    }
                                    
                                    else if (item == .plus || item == .minus || item == .multiple || item == .devide || item == .clear) {
                                        totalNumber = "0"
                                    }
                                    
                                    else {
                                        totalNumber = item.buttonDisplayName
                                        isNotEditing = false
                                    }
                                }
                                else {
                                    if(item == .clear) {
                                        totalNumber = "0"
                                        isNotEditing = true
                                    }
                                    
                                    else if (item == .plus) {
                                        tempNumber = Int(totalNumber)!
                                        operatorType = .plus
                                        isNotEditing = true
                                    }
                                    
                                    else if (item == .minus) {
                                        tempNumber = Int(totalNumber)!
                                        operatorType = .minus
                                        isNotEditing = true

                                    }
                                    else if (item == .multiple) {
                                        tempNumber = Int(totalNumber)!
                                        operatorType = .multiple
                                        isNotEditing = true
                                    }
                                    
                                    else if (item == .equal) {
                                        if(operatorType == .plus) {
                                            totalNumber = String(tempNumber + Int(totalNumber)!)
                                        }
                                        
                                        else if (operatorType == .minus) {
                                            totalNumber = String(tempNumber - Int(totalNumber)!)
                                        }
                                        
                                        else if (operatorType == .multiple) {
                                            totalNumber = String(tempNumber * Int(totalNumber)!)
                                        }
                                        
                                        else if (operatorType == .devide) {
                                            totalNumber = String(tempNumber / Int(totalNumber)!)
                                        }
                                    }
                                    
                                    else {
                                        totalNumber += item.buttonDisplayName
                                    }
                                }
                            } label: {
                                Text(item.buttonDisplayName).frame(width: item == .zero ? calculateButtonWidth(button: item) : calculateButtonWidth(button: item), height: calculateButtonHight(button: item)).background(item.backgroundColor).cornerRadius(40).foregroundColor(item.foregroundColor).font(.system(size: 40, weight: .medium))
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    private func calculateButtonWidth(button buttonType: ButtonType) -> CGFloat {
        switch buttonType{
        case .zero:
            return ((UIScreen.main.bounds.width - 5*10) / 4) * 2
        default:
            return (UIScreen.main.bounds.width - 5*10) / 4
        }
    }
    
    private func calculateButtonHight(button: ButtonType) -> CGFloat {
            return (UIScreen.main.bounds.width - 5*10) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
