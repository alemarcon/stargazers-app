//
//  NetworkRequestPerformer.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation
import Alamofire

class NetworkRequestPerfomer {
    
    fileprivate static let MESSAGE = "message"
    
    /// A generic network request performer for execute all request for router that extends APIConfiguration
    /// - Parameter route: Router object
    /// - Parameter success: success operation
    /// - Parameter failure: fail operation
    public static func performRequest<T:Decodable>(route: APIConfiguration, success: @escaping (T) -> Void, failure: @escaping ((NetworkError) -> Void)) -> DataRequest {
        
        return AF.request(route, interceptor: route.interceptor)
            .responseJSON { response in
                do {
                    if response.error != nil {
                        
                        if let error = response.error, let underlyingError = error.underlyingError {
                            if let urlError = underlyingError as? URLError {
                                switch urlError.code {
                                case .timedOut:
                                    print("Timed out error")
                                    failure(NetworkError.timeout)
                                case .notConnectedToInternet:
                                    print("Not connected")
                                    failure(NetworkError.noConnection)
                                default:
                                    //Do something
                                    print("Unmanaged error")
                                    failure(NetworkError.generic(response.response?.statusCode ?? 0, "Unknow error"))
                                }
                            }
                        } else {
                            failure(NetworkError.generic(response.response?.statusCode ?? 0, "Unknow error"))
                        }
                    } else {
                        if let responseData = response.data {

                            if let statusCode = response.response?.statusCode {

                                switch statusCode {

                                case NetworkStatusCode.success.rawValue:
                                    success(try JSONDecoder().decode(T.self, from: responseData))

                                case NetworkStatusCode.notFound.rawValue:
                                    do {
                                        let jsonArray = try JSONSerialization.jsonObject(with: responseData, options : .allowFragments) as! [String:Any]
                                        let message = jsonArray[MESSAGE] as? String ?? "No error message"
                                        failure(NetworkError.notFound(message))
                                    } catch(let error) {
                                        print(error.localizedDescription)
                                        failure(NetworkError.generic(statusCode, error.localizedDescription))
                                    }
                                default:
                                    do {
                                        let jsonArray = try JSONSerialization.jsonObject(with: responseData, options : .allowFragments) as! [String:Any]
                                        let message = jsonArray[MESSAGE] as? String ?? "No error message"
                                        failure(NetworkError.notFound(message))
                                    } catch(let error) {
                                        print(error.localizedDescription)
                                        failure(NetworkError.generic(statusCode, error.localizedDescription))
                                    }
                                }
                            } else {
                                failure(NetworkError.generic(0, "No status code retrieved"))
                            }

                        } else {
                            failure(NetworkError.dataNil)
                        }
                    }
                } catch {
                    let localizedErrorDescription: String = error.localizedDescription
                    print("Error: \(error)")
                    failure(NetworkError.generic(0, localizedErrorDescription))
                }
            }
    }

}
