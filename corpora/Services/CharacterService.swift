//
//  CharacterService.swift
//  corpora
//
//  Created by David Ortego Lucas on 4/11/22.
//

import Foundation

protocol NetWorkServiceProtocol {
    func getCharacters(next: String? , filter: String?, query: String?, completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void )
    func getEpisode(url: String, completion: @escaping (Swift.Result<Episode, Error>) -> Void)
}

class NativeURLSessionNetworkService : NetWorkServiceProtocol {
    
    func getEpisode(url: String, completion: @escaping (Swift.Result<Episode, Error>) -> Void) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(.failure(CustomError.noConnection))
            return
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode != 200){
                    completion(.failure(CustomError.failedRequest))
                    return
                }
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Episode.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
    func getCharacters(next: String? , filter: String?, query: String?, completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void ) {
        
        //var url = next != nil ? next! : EndPoint.characters.url
        
        var url = next ?? EndPoint.characters.url
        
        if let _query = query,let _filter = filter {
            url = url.appending("?").appending(_query).appending("=").appending(_filter)
        }
        
        guard Reachability.isConnectedToNetwork() else {
            completion(.failure(CustomError.noConnection))
            return
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode != 200){
                    completion(.failure(CustomError.failedRequest))
                    return
                }
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
}

class NetWorkManager {
    
    private let webservice : NetWorkServiceProtocol
    
    init(wbs : NetWorkServiceProtocol)
    {
        self.webservice = wbs
    }
    
    func apiCall_GetCharacters(next: String?, filter: String?, query: String?, completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void) {
        return self.webservice.getCharacters(next: next, filter: filter, query: query) { result in
            completion(result)
        }
    }
    
    func apiCall_GetEpisodes(urlEpisodes: [String], completion: @escaping (Swift.Result<[Episode], Error>) -> Void) {
        
        let dispatchQueue = DispatchQueue(label: "callsQueue", qos: .background)
        
        var episodes = [Episode]()
        
        // SYNC CODE
        /*let semaphore = DispatchSemaphore(value: 0)
        
        if(urlEpisodes.count == 0)
        {
            completion(.failure(CustomError.noData))
        }
        else
        {
            dispatchQueue.async {
                for url in urlEpisodes {
                    self.webservice.getEpisode(url: url) { episode in
                        switch episode{
                        case .success(let _episode):
                            episodes.append(_episode)
                            semaphore.signal()
                            break
                        case .failure(let error):
                            print(error)
                            semaphore.signal()
                            completion(.failure(error))
                        }
                    }
                    semaphore.wait()
                }
                completion(.success(episodes))
            }
        }*/
        
        // CONCURRENT CODE
        if(urlEpisodes.count == 0)
        {
            completion(.failure(CustomError.noData))
        }
        else
        {
            let group = DispatchGroup()
            var failure = false
            
            for url in urlEpisodes {
                group.enter()
                self.webservice.getEpisode(url: url) { episode in
                    switch episode{
                    case .success(let _episode):
                        episodes.append(_episode)
                        group.leave()
                        break
                    case .failure(let error):
                        print("error retrieving episodes \(error.localizedDescription)");
                        failure = true
                        group.leave()
                    }
                }
            }
            group.notify(queue: dispatchQueue )
            {
                if(failure)
                {
                    completion(.failure(CustomError.failedRequest))
                }
                else
                {
                    completion(.success(episodes))
                }
            }
        }
    }
}
