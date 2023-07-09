//
//  Requester.swift
//  WeatherForecast
//
//  Created by TasitS on 9/7/2566 BE.
//

import Foundation

class DataRequester {
    
    static let sharedInstance = DataRequester()
    
    func performRequest(_ urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)  {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    // delegate?.didFailWithError(error: error!)
                    completion(nil, error)
                    print("error")
                    return
                }
                
                if let safeData = data {
                    completion(safeData, nil)
                }
            }
            task.resume()
        }
    }
}
