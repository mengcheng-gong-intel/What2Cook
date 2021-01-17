//
//  FoodResultView.swift
//  What2Cook
//
//  Created by Maizi Liao on 2021-01-16.
//

import SwiftUI

struct FoodResultView: View {
    var foodResults: [Food]
    
    var body: some View {
        NavigationView {
            List(foodResults) { food in
                FoodRowView(food: food)
            }
            .navigationTitle("What to Cook...")
        }
    }
}

struct FoodResultView_Previews: PreviewProvider {
    static var previews: some View {
        FoodResultView(foodResults: [Food]())
    }
}
