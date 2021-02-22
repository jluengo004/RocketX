//
//  Services.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 15/2/21.
//

import Foundation

class Services {
    
    private var baseURL = "https://api.spacexdata.com/v4/"
    private var rocketApi = "rockets/"
    
    //TO-DO: change try! to try?
    public func getAllRockets(timeOut: Double, completion: @escaping ([Rocket]?, Error?) -> Void) {
        guard let url = URL(string: baseURL + rocketApi) else { return }
        httpGet(url: url, timeOut: timeOut) { (rocketsData, error) in
            if let error = error {
                completion(nil, error)
            }
            if let rocketsData = rocketsData {
                let rockets = try! JSONDecoder().decode(Rockets.self, from: rocketsData)
                completion(rockets, nil)
            }
            
        }
    }
    
    /*
    //Future implementations, favorite list f.ex.
    public func getRocketByID(rocketID: String, timeOut: Double, completion: @escaping (Rocket?, Error?) -> Void) {
        guard let url = URL(string: baseURL + rocketApi + rocketID) else { return }
        httpGet(url: url, timeOut: timeOut) { (rocketData, error) in

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
    }*/
    
    
    private func httpGet(url: URL, timeOut: Double,  completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = timeOut
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
