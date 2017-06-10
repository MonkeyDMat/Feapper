//
//  JSONHelper.swift
//  Feapper
//
//  Created by mathieu lecoupeur on 10/06/2017.
//  Copyright © 2017 mathieu lecoupeur. All rights reserved.
//

import Foundation

class JSONHelper {
    
    static func loadJSON(filename: String, bundle: Bundle = Bundle(for: JSONHelper.self)) -> NSDictionary? {
        
        if let url = bundle.url(forResource: filename, withExtension: "json") {
            if let data = NSData(contentsOf: url) {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
                    
                    return dictionary
                } catch {
                    print("Error!! Unable to parse  \(filename).json")
                }
            }
            print("Error!! Unable to load  \(filename).json")
        }
        
        return nil
    }
}
