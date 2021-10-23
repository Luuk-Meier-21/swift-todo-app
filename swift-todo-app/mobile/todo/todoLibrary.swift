//
//  todoLibrary.swift
//  mobile
//
//  Created by Luuk Meier on 04/10/2021.
//

import Foundation
import SwiftUI

struct TodoLibrary: HasStack {
    var array: [TodoList];
    var storageKey: String;
}

struct TodoLibraryView: View {
    @StateObject var userInput = UserInput();
    @StateObject var list = StorableData<TodoLibrary>(
        TodoLibrary(
            array: [],
            storageKey: "libs"
        )
    );

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(Array(list.data.array.enumerated()), id: \.offset) { index, item in
                        NavigationLink(destination:
                            TodoListView(
                                TodoList(
                                    title: item.title,
                                    index: index,
                                    storageKey: item.storageKey
                                )
                            )
                        ) {
                            Text(String(item.index));
                            Text(item.title);
                        }
                    }
                }
                InputSubmitter(
                    input: userInput
                ) {
                    list.submit(
                        TodoList(
                            title: userInput.text,
                            index: list.data.array.count + 1,
                            storageKey: "key_\(userInput.text)"
                        )
                    )
                }
            }
        }
    }
}
