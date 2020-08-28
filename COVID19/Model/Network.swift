//
//  Network.swift
//  COVID19
//
//  Created by Charity Hsu on 8/27/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import Foundation

class Network {
    
    static func getData(from url: URL, completion: @escaping (Response) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            do {
                let myResponse: Response = try JSONDecoder().decode(Response.self, from: data)
                completion(myResponse)
            } catch {
                print("failed to decode \(error.localizedDescription)")
            }
            
        }
        task.resume()
        
    }
    
}
