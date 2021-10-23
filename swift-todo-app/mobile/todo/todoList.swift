//
//  todoList.swift
//  mobile
//
//  Created by Luuk Meier on 24/09/2021.
//

import Foundation
import SwiftUI

//struct TodoListRef: Storable, StackItem {
//    var title: String;
//    var index: Int;
//    var storageKey: String;
//}

struct TodoList: Storable, HasStack, StackItem {
    var array: [TodoItem] = [];
    var title: String;
    var index: Int;
    var storageKey: String;
    
    init(title: String, index: Int, storageKey: String) {
        self.title = title;
        self.index = index;
        self.storageKey = storageKey;
    }
    
    static var empty = TodoList(
        title: "default",
        index: 0,
        storageKey: "default-key"
    )
    
    static func namedEmpty(_ name: String) -> TodoList {
        return TodoList(
            title: name,
            index: 0,
            storageKey: name
        )
    }
}

struct TodoListView: View {
    @StateObject var userInput = UserInput();
    @StateObject var list: StorableData<TodoList>;
    
    init(_ initialList: TodoList) {
        _list = StateObject(wrappedValue: StorableData<TodoList>(initialList))
    }

    var body: some View {
        return VStack(alignment: .leading) {
            Text(list.data.title)
                .fontWeight(.bold)
                .font(.largeTitle)
            ZStack(alignment: .bottom) {
                if (list.data.array.isEmpty) {
                    VStack(alignment: .center) {
                        Text("Deze lijst is leeg, voeg wat dingen toe.")
                            .foregroundColor(Color(UIColor.separator))
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(list.data.array, id: \.self) { item in
                                TodoItemView(
                                    data: item,
                                    onDelete: {
                                        list.delete(item)
                                    }
                                )
                                    .hoverEffect()
                                    .animation(.easeOut)
                            }
                        }
                            .padding(.bottom, 50)
                    }
                    Gradient();
                }
            }
            Spacer();
            InputSubmitter(
                input: userInput
            ) {
                list.submit(
                    TodoItem(
                        text: userInput.text,
                        index: list.data.array.count + 1
                    )
                )
                userInput.clear()
            }
        }.padding()
    }
}
