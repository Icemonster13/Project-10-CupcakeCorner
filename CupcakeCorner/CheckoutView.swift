//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Michael & Diana Pascucci on 5/12/22.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: SharedOrder
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    // Added New Alert As Part of Challenge 2.2
    @State private var showingOrderFailed: Bool = false
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(OrderModel.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(SharedOrder.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed")
            showingOrderFailed = true
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.data.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        // Added New Alert As Part of Challenge 2.2
        .alert("Order Failed", isPresented: $showingOrderFailed) {
            Button("OK") { }
        } message: {
            Text("Your order has failed. Please check your internet connection and try again.")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: SharedOrder())
    }
}
