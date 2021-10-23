//
//  stylers.swift
//  mobile
//
//  Created by Luuk Meier on 08/10/2021.
//

import Foundation
import SwiftUI

//typealias AppColor = Color;
//
//extension AppColor {
//    static var appBackground: AppColor = AppColor()
//}

struct Gradient: View {
    var color: UIColor = UIColor.systemBackground
    var maxHeight: CGFloat = 50;
    
    var body: some View {
        LinearGradient(
            gradient: SwiftUI.Gradient(colors: [
                Color(color),
                Color(color.withAlphaComponent(0))
            ]),
            startPoint: .bottom,
            endPoint: .top
            )
            .frame(maxHeight: maxHeight)
    }
    
}
