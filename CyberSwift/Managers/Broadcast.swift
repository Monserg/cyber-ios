//
//  Broadcast.swift
//  CyberSwift
//
//  Created by msm72 on 15.05.2018.
//  Copyright © 2018 Golos.io. All rights reserved.
//

import Foundation

/// Array of request unique IDs
public var requestIDs   =   [Int]()

/// Type of request API
public typealias RequestMethodAPIType   =   (id: Int, requestMessage: String?, methodAPIType: MethodAPIType, errorAPI: ErrorAPI?)

/// Type of response API
public typealias ResponseAPIType        =   (responseAPI: Decodable?, errorAPI: ErrorAPI?)
public typealias ResultAPIHandler       =   (Decodable) -> Void
public typealias ErrorAPIHandler        =   (ErrorAPI) -> Void

/// Type of stored request API
public typealias RequestMethodAPIStore  =   (methodAPIType: MethodAPIType, completion: (ResponseAPIType) -> Void)


public class Broadcast {
    // MARK: - Properties
    public static let instance = Broadcast()
    
    
    // MARK: - Class Initialization
    private init() {}
    
    deinit {
        Logger.log(message: "Success", event: .severe)
    }
    
    
    // MARK: - Class Functions

    /// Completion handler
    func completion<Result>(onResult: @escaping (Result) -> Void, onError: @escaping (ErrorAPI) -> Void) -> ((Result?, ErrorAPI?) -> Void) {
        return { (maybeResult, maybeError) in
            if let result = maybeResult {
                onResult(result)
            }
                
            else if let error = maybeError {
                onError(error)
            }
                
            else {
                onError(ErrorAPI.requestFailed(message: "Result not found"))
            }
        }
    }
    

    /// Generating a unique ID
    //  for content:                < 100
    private func generateUniqueId(forType type: Any) -> Int {
        var generatedID = 0
        
        repeat {
            if type is MethodAPIType {
                generatedID = Int(arc4random_uniform(100))
            }
        } while requestIDs.contains(generatedID)
        
        requestIDs.append(generatedID)
        
        return generatedID
    }
}


// MARK: - Microservices
extension Broadcast {
    /// Prepare method request
    private func prepareGETRequest(methodAPIType: MethodAPIType) -> RequestMethodAPIType {
        Logger.log(message: "Success", event: .severe)
        
        let codeID              =   generateUniqueId(forType: methodAPIType)
        let requestParamsType   =   methodAPIType.introduced()
        
        let requestAPI          =   RequestAPI(id:          codeID,
                                               method:      String(format: "%@.%@", requestParamsType.methodGroup, requestParamsType.methodName),
                                               jsonrpc:     "2.0",
                                               params:      requestParamsType.parameters)
        
        do {
            // Encode data
            let jsonEncoder     =   JSONEncoder()
            var jsonData        =   Data()
            var jsonString: String
            
            switch methodAPIType {
            case .getProfile(_), .getFeed(typeMode: _):
                jsonData        =   try jsonEncoder.encode(requestAPI)
                jsonString      =   "\(String(data: jsonData, encoding: .utf8)!)"
            }
            
            jsonString          =   jsonString
                                        .replacingOccurrences(of: "[[[", with: "[[")
                                        .replacingOccurrences(of: "[\"nil\"]", with: "]")
            
            Logger.log(message: "\nEncoded JSON -> String:\n\t " + jsonString, event: .debug)
            
            // Template: { "id": 2, "jsonrpc": "2.0", "method": "content.getProfile", "params": { "userId": "tst3uuqzetwf" }}
            return (id: codeID, requestMessage: jsonString, methodAPIType: requestParamsType.methodAPIType, errorAPI: nil)
        } catch {
            Logger.log(message: "Error: \(error.localizedDescription)", event: .error)
            
            return (id: codeID, requestMessage: nil, methodAPIType: requestParamsType.methodAPIType, errorAPI: ErrorAPI.requestFailed(message: "Broadcast, line 406: \(error.localizedDescription)"))
        }
    }
    

    /// Execute content request
    public func executeGETRequest(byContentAPIType methodAPIType: MethodAPIType, onResult: @escaping (Decodable) -> Void, onError: @escaping (ErrorAPI) -> Void) {
        // Prepare content request
        let requestMethodAPIType = self.prepareGETRequest(methodAPIType: methodAPIType)
        
        guard requestMethodAPIType.errorAPI == nil else {
            onError(ErrorAPI.requestFailed(message: "Broadcast, line 352: \(requestMethodAPIType.errorAPI!.localizedDescription)"))
            return
        }
        
        Logger.log(message: "\nrequestMethodAPIType:\n\t\(requestMethodAPIType.requestMessage!)\n", event: .debug)
        
        // Send content request messages to `FACADE-SERVICE`
        WebSocketManager.instance.sendRequest(methodAPIType: requestMethodAPIType, completion: { responseAPIType in
            if let responseAPI = responseAPIType.responseAPI {
                onResult(responseAPI)
            }
                
            else {
                onError(ErrorAPI.responseUnsuccessful(message: "Broadcast, line 365: \(requestMethodAPIType.errorAPI!.localizedDescription)"))
            }
        })
    }
}
