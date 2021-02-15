//
//  Services.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import Foundation

class Services {
    
    
    //TO-DO: change try! to try?
    public func getAllRockets(completion: @escaping ([Rocket]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        httpGet(url: url) { (rocketsData, error) in
            
            if let error = error {
                completion(nil, error)
            }
            if let rocketsData = rocketsData {
                let rockets = try! JSONDecoder().decode(Rockets.self, from: rocketsData)
                completion(rockets, nil)
            }
            
        }
    }
    
    
    public func getRocketByID(rocketID: String, completion: @escaping (Rocket?, Error?) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets/" + rocketID) else { return }
        httpGet(url: url) { (rocketData, error) in

            print(error)
            
            if let error = error {
                completion(nil, error)
            }
            if let rocketData = rocketData {
                let rocket = try! JSONDecoder().decode(Rocket.self, from: rocketData)
                print(rocket)
                completion(rocket, nil)
            }
            
        }
    }
    
    
    private func httpGet(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: ", error)
                completion(nil, error)
            }
            
            if let data = data {
                completion(data, nil)
            }
            
        }
        task.resume()
    }
}
