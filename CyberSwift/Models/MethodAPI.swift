//
//  MethodAPI.swift
//  CyberSwift
//
//  Created by msm72 on 12.04.2018.
//  Copyright © 2018 Golos.io. All rights reserved.
//
//  This enum use for GET Requests
//
//  https://github.com/GolosChain/facade-service/tree/develop
//

import Foundation

/// Type of request parameters
typealias RequestMethodParameters   =   (methodAPIType: MethodAPIType, methodGroup: String, methodName: String, parameters: [String: String])

public enum MethodAPIGroup: String {
    case offline            =   "offline"
    case options            =   "options"
    case onlineNotify       =   "onlineNotify"
    case push               =   "push"
    case notify             =   "notify"
    case favorites          =   "favorites"
    case meta               =   "meta"
    case frame              =   "frame"
    case registration       =   "registration"
    case rates              =   "rates"
    case content            =   "content"
}

public enum FeedTypeMode: String {
    case community          =   "community"
    case subscriptions      =   "subscriptions"
    case byUser             =   "byUser"
}

public enum FeedTimeFrameMode: String {
    case day                =   "day"
    case week               =   "week"
    case month              =   "month"
    case year               =   "year"
    case all                =   "all"
    case wilsonHot          =   "WilsonHot"
    case wilsonTrending     =   "WilsonTrending"
}

public enum FeedSortMode: String {
    case time               =   "time"
    case timeDesc           =   "timeDesc"
    case popular            =   "popular"
}

public indirect enum MethodAPIType {
    /// Getting a user profile
    case getProfile(nickNames: String)

    /// Getting tape posts
    case getFeed(typeMode: FeedTypeMode, userID: String?, communityID: String?, timeFrameMode: FeedTimeFrameMode, sortMode: FeedSortMode, paginationLimit: Int8, paginationSequenceKey: String?)

    
    /// This method return request parameters from selected enum case.
    func introduced() -> RequestMethodParameters {
        switch self {
        /// Template { "id": 2, "jsonrpc": "2.0", "method": "content.getProfile", "params": { "userId": "tst3uuqzetwf" }}
        case .getProfile(let userNickName):
            return  (methodAPIType:     self,
                     methodGroup:       MethodAPIGroup.content.rawValue,
                     methodName:        "getProfile",
                     parameters:        ["userId": userNickName])
            
        ///
        case .getFeed(let typeMode, let userID, let communityID, let timeFrameMode, let sortMode, let paginationLimit, let paginationSequenceKey):
            var parameters: [String: String] = ["type": typeMode.rawValue, "timeframe": timeFrameMode.rawValue, "sortBy": sortMode.rawValue, "limit": "\(paginationLimit)"]
            
            if let userIDValue = userID {
                parameters["userId"] = userIDValue
            }
            
            if let communityIDValue = communityID {
                parameters["communityId"] = communityIDValue
            }
            
            if let paginationSequenceKeyValue = paginationSequenceKey {
                parameters["sequenceKey"] = paginationSequenceKeyValue
            }
            
            return  (methodAPIType:     self,
                     methodGroup:       MethodAPIGroup.content.rawValue,
                     methodName:        "getFeed",
                     parameters:        parameters)
        } // switch
    }
}
