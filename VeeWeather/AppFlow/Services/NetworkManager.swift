//
//  NetworkManager.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getWeatherData(city: String, completion: @escaping (Result<WeatherModel>) -> Void)
}

class NetworkDataManager: NSObject{
    
    // Create a singleton
    private override init() {
        
    }
    static let _shared = NetworkDataManager()
    
    class func shared()-> NetworkDataManager{
        
        return _shared
    }
}

extension NetworkDataManager: NetworkManagerProtocol{
    func getWeatherData(city: String, completion: @escaping (Result<WeatherModel>) -> Void) {
        let token = DefaultUtils.sharedInstance.token.orEmpty
        let requestParams: [String: Any] = [
            "appid": token,
            "mode": "json",
            "q": city
        ]
        
        let request = NetworkRequests.shared.setUrlRequest(
            urlString: BasePath.baseUrl.description,
            method: .post,
            params: [:],
            querryParams: requestParams,
            header: [:]
        )
        
        LoadingIndicator.shared.show()
        Network.execute(request: request) { (response) in
            switch response {
            case.success(let data):
                ParserDecoder.decodeObject(data: data) { (resp: WeatherModel?, _) in
                    if let friendResp = resp {
                        completion(.success(friendResp))
                        LoadingIndicator.shared.hide()
                    } else {
                        log.error("After decoding the model the result got failed")
                    }
                }
            case .failure(let error):
                log.error("Failed to parsing the weather model please check the erre bellow")
                log.verbose("-------------------------ERROR------------------------")
                log.debug(error)
                log.verbose("-------------------------ERROR------------------------")
                completion(.failure(APIError.parsingFailed))
                LoadingIndicator.shared.hide()
            }
        }
    }
}
