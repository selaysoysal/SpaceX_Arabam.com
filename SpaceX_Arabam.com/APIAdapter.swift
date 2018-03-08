//
//  APIAdapter.swift
//  SpaceX_Arabam.com
//
//  Created by Selay Soysal on 4.03.2018.
//  Copyright © 2018 Selay Turkmen. All rights reserved.
//

import UIKit

class APIAdapter: NSObject {

    func getLaunches(completion:@escaping(Data) -> (Void))
    {
        let url = URL(string: "https://api.spacexdata.com/v2/launches")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error ) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:AnyObject]]
                    print(json)
                    DispatchQueue.main.async {
                        completion(data)
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
             else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
