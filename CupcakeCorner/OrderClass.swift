//
//  Order.swift
//  CupcakeCorner
//
//  Created by Michael & Diana Pascucci on 5/12/22.
//

import SwiftUI

struct OrderModel: Codable {        // Struct created as part of Challenge 2.3
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    // Added Removal of WhiteSpaces as part of Challenge 2.1
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            city.trimmingCharacters(in: .whitespaces).isEmpty ||
            zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
}

class SharedOrder: ObservableObject {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = OrderModel()

//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//
//    Moved to Struct OrderModel as part of Challenge 2.3
//    @Published var type = 0
//    @Published var quantity = 3
//
//    @Published var specialRequestEnabled = false {
//        didSet {
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//
//    @Published var extraFrosting = false
//    @Published var addSprinkles = false
//
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
//
//    // Added Removal of WhiteSpaces as part of Challenge 2.1
//    var hasValidAddress: Bool {
//        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
//            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
//            city.trimmingCharacters(in: .whitespaces).isEmpty ||
//            zip.trimmingCharacters(in: .whitespaces).isEmpty {
//            return false
//        }
//        return true
//    }
//
//    var cost: Double {
//        var cost = Double(quantity) * 2
//
//        cost += (Double(type) / 2)
//
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//        return cost
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//
//    init() { }
    
}
