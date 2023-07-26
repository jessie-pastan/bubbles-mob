//
//  Extention.swift
//  Bubbles
//
//  Created by Jessie P on 7/24/23.
//

import Foundation
// this extention will encoding user struct into data(dictionary)
extension Encodable {
    func asDictionary() -> [String : Any] {
        //try to get data from encoder
        guard let data = try? JSONEncoder().encode(self) else{
            return [:]
        }
        // when we got data convert this to JSON(dictionary)
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        }catch{
            return [:]
        }
    }
}
