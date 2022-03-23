//
//  APIService.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    struct Auth {
        
        static let token: String = "s_1pg9SkycACttNhl2eBegXgoHzwt8ph-Gb6VhzllsPpAEx20Aq8_-QgJ-_MpGVW2OPoEHyrVr6yqNVPok6fNT0fsbKkU3NJEJM7pc-e8Faj1LNRy_K3-dwLyQk7YnYx"
        
    }
    
    enum Endpoints {
        
        static let baseURL: String = "https://api.yelp.com/v3/businesses/"
        
        case searchByParameters(location: String, term: String, sortBy: String)
        
        var stringValue: String {
            switch self {
            case .searchByParameters(location: let location, term: let term, sortBy: let sortBy):
                return Endpoints.baseURL + "search?location=\(location)&term=\(term)&sort_by=\(sortBy)"
            }
        }
        
        var url: URL {
            
            return URL(string: stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
            
        }
        
    }
    
    func getAttractions(location: String = "Singapore", term: String, sortBy: String = "Distance", completion: @escaping(Result?, Error?)->Void) {
        
        let url: URL = Endpoints.searchByParameters(location: location, term: term, sortBy: sortBy).url
        var request: URLRequest = URLRequest(url: url)
        request.setValue( "Bearer \(Auth.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                debugPrint("Error, data is nil")
                
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let dataResponse = try decoder.decode(Result.self, from: data)
                DispatchQueue.main.async {
                    completion(dataResponse, nil)
                }
            } catch {
                debugPrint("Failed to Decode Data")
                completion(nil, error)
            }
        }
        task.resume()
        
    }
    
}
