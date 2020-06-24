//
//  AdditionalViews.swift
//  OtusDZ2
//
//  Created by Георгий Хайденко on 18.03.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import SwiftUI

// 2
struct SecondView: View {
    var body: some View {
        VStack {
            NavPopButton(destination: .previous) {
                Text("Pop to Previous (1)")
            }
            NavPushButton(destination: ThirdView()) {
                Text("Push to Screen №3")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
    }
}
// 3
struct ThirdView: View {
    var body: some View {
        VStack {
            NavPopButton(destination: .previous) {
                Text("Pop to Previous (2)")
            }
            NavPopButton(destination: .root) {
                Text("Pop to Root")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
    }
}

struct RecipeView: View {
    var recipe: Recipe
    var body: some View {
            VStack(alignment: .center) {
                Text (recipe.title ?? "no title")
                    .multilineTextAlignment(.center)
                NavigationLink(destination: IngredientsView(recipe: recipe))
                {
                    Text("Push for ingredients")
                }
                Spacer()
            }
            .navigationBarTitle("Recipe")
    }
}

struct  IngredientsView: View {
    var recipe: Recipe
    var body: some View {
        VStack {
            Text (recipe.ingredients ?? "no ingredients")
                .padding()
            Spacer()
        }
    .navigationBarTitle("Ingredients")
    }
}
