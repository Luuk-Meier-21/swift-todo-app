//
//  ContentView.swift
//  mobile
//
//  Created by Luuk Meier on 22/09/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userInput = UserInput();
    
    var body: some View {
        ZStack {
            Color(UIColor.brown).ignoresSafeArea()
            VStack(alignment: .leading) {
                TodoLibraryView();
    //            TodoListView(
    //                TodoList.empty
    //            );
            }
        }
    }
 }




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 13 Pro")
        }
    }
}
