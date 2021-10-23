//
//  todoItem.swift
//  mobile
//
//  Created by Luuk Meier on 24/09/2021.
//

import Foundation
import SwiftUI

struct TodoItem: StackItem, Hashable {
    var text: String;
    var index: Int;
}

struct TodoItemView: View {
    var data: TodoItem;
    var onDelete: () -> Void;
    var body: some View {
        
        HStack(
            alignment: .firstTextBaseline,
            spacing: 10
        ) {
            Text(String(data.index));
            Text(data.text).frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            Button(action: {
                onDelete()
            }) {
                
                Label("", systemImage: "trash")
                    .labelStyle(IconOnlyLabelStyle())
            }
        }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor.separator), lineWidth: 1)
            )
            .padding(1)
    }
}
