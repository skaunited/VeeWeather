//
//  NetworkRequests.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//
import Foundation
import Alamofire
/// Class generique pour la préparation des requettes.
///
/// Iimplementation de protocole URLRequestConvertible
class NetworkRequests {
    
    // MARK: - DesignPattern : Singleton
    /// instance unique de manager
    static let shared = NetworkRequests()
    
    // MARK : - Properties
    /// variable globale url request optionnel
    var urlRequest: URLRequest?
    
    // MARK: - prepare request function
    /// préparation de la requette
    ///
    /// input ( url: String, method: httpMethod, params: [String, Any], header: [String, String]
    ///
    ///output URLRequest
    func setUrlRequest(urlString: String, method: HTTPMethod, params: [String: Any],querryParams: [String: Any], header: [String: String]) -> URLRequest {
        /// init values
        // init URL
        var urlToUse =  urlString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        urlToUse = urlToUse.folding(options: .diacriticInsensitive, locale: .current)
        let url = URL(string: urlToUse)!
        var urlRequest = URLRequest(url: url)
        var queryItems: [URLQueryItem] = [URLQueryItem]()
        // init method
        urlRequest.httpMethod = method.rawValue
        // init params
        var parameters = params
        /// tester si la methode .get ou non pour ajouter les parametres
        // urlRequest.timeoutInterval = 10
        if method != .get {
            
            if !params.isEmpty {
                do {
                    /// si methode est non .get
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options:  .prettyPrinted)
                } catch {
                    debugPrint("can't add params to request")
                }
            }
            if  !querryParams.isEmpty{
                parameters = querryParams
                guard let parameters = parameters as? Dictionary<String, Any> ,
                      let  urlComponents = NSURLComponents(
                        url: url,
                        resolvingAgainstBaseURL: true
                      )
                else {
                    return urlRequest
                }
                if let parameters =  parameters as? Dictionary<String, Any> {
                    parameters.forEach { (item) in
                        queryItems.append(
                            URLQueryItem(
                                name: item.key,
                                value: "\(item.value) "
                            ))
                    }
                }
                urlComponents.queryItems = queryItems
                if let urlToReturn = urlComponents.url {
                    urlRequest.url = URL(
                        string: urlToReturn.absoluteString.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "%20", with: "", options: .literal,
                                                                                                                     range: nil
                        )
                    )
                }
            }
            if params.isEmpty && querryParams.isEmpty {
                urlRequest.httpBody = nil
            }
            
        } else {
            /// If methode is  .get
            if  !params.isEmpty{
                guard let parameters = parameters as? Dictionary<String, Any> ,
                      let  urlComponents = NSURLComponents(
                        url: url,
                        resolvingAgainstBaseURL: true
                      )
                else {
                    return urlRequest
                }
                if let parameters =  parameters as? Dictionary<String, Any> {
                    parameters.forEach { (item) in
                        queryItems.append(URLQueryItem(name: item.key, value: "\(item.value) "))
                    }
                }
                urlComponents.queryItems = queryItems
                if let urlToReturn = urlComponents.url {
                    urlRequest.url = URL(string: urlToReturn.absoluteString.replacingOccurrences(of: "", with: "%20", options: .literal, range: nil))
                }
            } else {
                urlRequest.httpBody = nil
            }
        }
        // init header
        urlRequest.allHTTPHeaderFields = header
        // affecter la requette au urlRequest
        self.urlRequest = urlRequest
        return urlRequest
    }
}

extension NetworkRequests : URLRequestConvertible{
    // MARK: - Delegate functions
    /// input: none
    ///
    ///output: URLRequest
    func asURLRequest() throws -> URLRequest {
        return  urlRequest!
    }
}

extension NetworkRequests {
    static func readJSONFromFile<T>(fileName: String,model: T.Type) -> T? where T : Codable {
        var objectToReturn: T?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                objectToReturn = try decoder.decode(model.self, from: data)
            } catch (let error) {
                debugPrint(error.localizedDescription)
            }
        }
        return objectToReturn
    }
}
