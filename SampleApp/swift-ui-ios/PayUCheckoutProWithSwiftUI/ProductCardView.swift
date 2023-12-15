//
//  ProductCardView.swift
//  CheckoutProSwiftWithoutFrameworkSampleApp
//
//  Created by Shubham Garg on 14/12/23.
//  Copyright © 2023 PayU Payments Pvt Ltd. All rights reserved.
//

import SwiftUI

struct ProductCardView: View {
    
    var image:Image   = Image("books")  // Featured Image
    var price:Double   = 1.00  // USD
    var title:String  = "Intorduction to Swift UI"  // Product Title
    var description:String  = "A handbook to learn Swift UI Basics and create TODO app"// Product Description
    var ingredientCount:Int  = 500// # of Ingredients
    var peopleCount:Int  = 1   // Servings
    var category:String? = "Books"    // Optional Category
    var buttonHandler: (()->())?
    
    init(title:String, description:String, image:Image, price:Double, peopleCount:Int, ingredientCount:Int, category:String?, buttonHandler: (()->())?) {
        
        self.title = title
        self.description = description
        self.image = image
        self.price = price
        self.peopleCount = peopleCount
        self.ingredientCount = ingredientCount
        self.category = category
        self.buttonHandler = buttonHandler
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // Main Featured Image - Upper Half of Card
                self.image
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                    .clipped()
                    .overlay(
                        Text("Best Seller")
                            .fontWeight(Font.Weight.medium)
                            .font(Font.system(size: 16))
                            .foregroundColor(Color.white)
                            .padding([.leading, .trailing], 8)
                            .padding([.top, .bottom], 8)
                            .background(Color.black.opacity(0.5))
                        , alignment: .topLeading)
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text(self.title)
                        .fontWeight(Font.Weight.heavy)
                    Text(self.description)
                        .font(Font.custom("HelveticaNeue-Bold", size: 16))
                        .foregroundColor(Color.gray)
                    
                    // 'Based on:' Horizontal Category Stack
                    HStack(alignment: .center, spacing: 6) {
                        
                        if category != nil {
                            Text("Based on:")
                                .font(Font.system(size: 13))
                                .fontWeight(Font.Weight.heavy)
                            HStack {
                                Text(category!)
                                    .font(Font.custom("HelveticaNeue-Medium", size: 12))
                                    .padding([.leading, .trailing], 10)
                                    .padding([.top, .bottom], 5)
                                    .foregroundColor(Color.white)
                            }
                            .background(Color(red: 43/255, green: 175/255, blue: 187/255))
                            .cornerRadius(7)
                            Spacer()
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            Text("Pages-")
                                .foregroundColor(Color.gray)
                            Text("\(self.ingredientCount)")
                        }.font(Font.custom("HelveticaNeue", size: 14))
                        
                    }
                    .padding([.top, .bottom], 8)
                    Spacer()
                    
                    // Price and Buy Now Stack
                    HStack(alignment: .center, spacing: 4) {
                        Text(String.init(format: "₹%.2f", arguments: [self.price]))
                            .fontWeight(Font.Weight.heavy)
                        Spacer()
                        Text("PAY NOW")
                            .fontWeight(Font.Weight.heavy)
                            .foregroundColor(Color(red: 231/255, green: 119/255, blue: 112/255))
                            .onTapGesture {
                                self.buttonHandler?()
                            }
                        
                    }.padding([.top, .bottom], 8)
                    
                    
                }
                .padding(12)
            }
            .padding()
            .background(Color.white)
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(title: "Intorduction to Swift UI", description: "Intorduction to Swift UI", image: Image("books"), price: 1.00, peopleCount: 1, ingredientCount: 500, category: "book", buttonHandler: nil)
    }
}
