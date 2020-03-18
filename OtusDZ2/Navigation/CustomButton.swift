//
//  CustomButton.swift
//  CustomNavigationView
//
//  Created by exey on 10.03.2020.
//  Copyright © 2020 exey. All rights reserved.
//

import SwiftUI

struct CustomButton<InnerContent>: View where InnerContent: View {
    
    private let action: ()->Void
    private let innerContent: ()->InnerContent
    
    init(action: @escaping ()->Void, @ViewBuilder innerContent: @escaping () -> InnerContent) {
        self.action = action
        self.innerContent = innerContent
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.green)
            HStack {
                self.innerContent()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
        }
        .fixedSize(horizontal: true, vertical: true)
        .simultaneousGesture(TapGesture().onEnded({
            self.action()
        }))
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: {}) {
            VStack {
                EmptyView()
                Text("Test")
            }
        }
    }
}
