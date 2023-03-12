//
//  SentimentAnalysis.swift
//  body positivity
//
//  Created by Sophia Yang on 2023-03-12.
//

import Foundation
import Alamofire //Imported this using Cocoapods
import SwiftyJSON //Imported this using Cocoapods

func analyzeSentiment(postText: String, apiKey: String, completion: @escaping (String?) -> Void) {
    let url = "https://api.cohere.ai/v1/sentiment"
    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(apiKey)",
        "Content-Type": "application/json"
    ]
    let parameters: [String: Any] = [
        "text": postText
    ]
    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let sentiment = json["sentiment"] as? String {
                    completion(sentiment)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
}
