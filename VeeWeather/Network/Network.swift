//
//  NetworkApi.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//

import UIKit
import Alamofire

public enum APIError: Error {
    case parsingFailed
    case notConnectedToInternet
    case timedOut
    case emptyData
}
struct Network {
    static func execute(request: URLRequestConvertible, completion: @escaping (Result<Data>) -> Void){
        if Connectivity.isConnectedToInternet() {
            Session.default.request(request)
                .validate()
                .responseData { alamofireResponse in
                    if let statusCode = alamofireResponse.response?.statusCode {
                        if statusCode == 401 {
                            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                                while let presentedViewController = topController.presentedViewController {
                                    topController = presentedViewController
                                }
                                //TODO: - here we handle unauthorized
                            }
                        }
                    }
              switch alamofireResponse.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        if error.localizedDescription.contains("data connection is not currently allowed") {
                        }
                        switch error {
                        case let err as NSError where err.code == NSURLErrorNotConnectedToInternet:
                            
                            completion(.failure(APIError.notConnectedToInternet))
                        case let err as NSError where err.code == NSURLErrorTimedOut:
                            completion(.failure(APIError.timedOut))
                        default:
                            
                            completion(.failure(error))
                            
                        }
                    }
                }.responseDebugPrint()
        } else {
            
            completion(.failure(APIError.notConnectedToInternet))
        }
    }
}

// MARK: - Debug request and result

extension Alamofire.DataRequest {
    
    func responseDebugPrint() {
        responseJSON() {
            response in
            if let JSON = try? response.result.get() {
                if let JSONData = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted),
                   let prettyString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
                    print(prettyString)
                } else if let error = response.error {
                    print("Error Debug Print: \(error.localizedDescription)")
                }
            }
        }
    }
}

public enum Result<Value> where Value : Codable {
    case success(Value)
    case failure(Error)
}

struct ParserDecoder {
    static func decodeObject<T>(data: Data, completionHandler: @escaping (T?, Error?) -> Void) where T: Codable {
        // As step one, you need to do networking to fetch `responseData`
        // code
        let decoder = JSONDecoder()
        
        do {
            let todo = try decoder.decode(T.self, from: data)
            completionHandler(todo, nil)
        } catch {
            print("error trying to convert data to JSON")
            print(error)
            completionHandler(nil, error)
        }
    }
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
