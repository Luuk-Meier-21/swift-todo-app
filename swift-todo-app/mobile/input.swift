//
//  InputField.swift
//  mobile
//
//  Created by Luuk Meier on 23/09/2021.
//

import Foundation
import SwiftUI


class UserInput: ObservableObject {
    @Published var text: String = ""
    
    var isEmpty: Bool {
        return text.isEmpty;
    }
    
    func clear() -> Void {
        text = "";
    }
}

struct Input: View {
    @EnvironmentObject var input: UserInput;
    @State var isEditing: Bool = false;
    var placeholder: String;
    
    init(_ placeholder: String = "Placeholder") {
        self.placeholder = placeholder
    }
    
    var body: some View {
        
        ZStack {
            TextField(placeholder, text: $input.text)
            { isEditing in
                self.isEditing = isEditing
                if isEditing {
                    
                }
            }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            Color(UIColor.separator),
                            lineWidth: 1
                        )
                        
                )
            if !input.isEmpty {
                HStack {
                    Button(action: {
                        input.clear()
                    }) {
                        Label("Clear", systemImage: "clear")
                            .labelStyle(IconOnlyLabelStyle())
                            .foregroundColor(Color(UIColor.separator))
                    }.padding()
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

struct InputSubmitter: View {
    var input: UserInput;
    var label: String = "Toevoegen";
    var bgColor: Color = Color(UIColor.secondarySystemBackground);
    var onSubmit: () -> Void;
    
    var body: some View {
        VStack {
            Input().environmentObject(input)
            HStack {
                Spacer()
                Button(action: {
                    onSubmit();
                    input.clear();
                }) {
                    Text(label)
                }
                    .disabled(input.isEmpty)
            }.padding(.top)
        }
    }
    
}
