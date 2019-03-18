//
//  ResponseAPI.swift
//  CyberSwift
//
//  Created by msm72 on 13.04.2018.
//  Copyright © 2018 Golos.io. All rights reserved.
//

import Foundation

// MARK: -
public struct ResponseAPIErrorResult: Decodable {
    // MARK: - In work
    public let error: ResponseAPIError
    public let id: Int64
    public let jsonrpc: String
}


// MARK: -
public struct ResponseAPIError: Decodable {
    // MARK: - In work
    public let code: Int64
    public let message: String
}


// MARK: -
public struct ResponseAPIContentGetProfileResult: Decodable {
    // MARK: - In work API `content.getProfile`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIContentGetProfile?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIContentGetProfile: Decodable {
    // MARK: - In work API `content.getProfile`
    public let subscriptions: ResponseAPIContentGetProfileSubscription
    public let stats: ResponseAPIContentGetProfileStat
    public let userId: String
    public let username: String
    public let registration: ResponseAPIContentGetProfileRegistration
    public let personal: ResponseAPIContentGetProfilePersonal
}


// MARK: -
public struct ResponseAPIContentGetProfileSubscription: Decodable {
    // MARK: - In work API `content.getProfile`
    public let userIds: [ResponseAPIContentGetProfileSubscriptionUserID?]
    public let communities: [ResponseAPIContentGetProfileSubscriptionCommunity]
}


// MARK: -
public struct ResponseAPIContentGetProfileSubscriptionUserID: Decodable {
    // MARK: - In work API `content.getProfile`
    public let id: String
}


// MARK: -
public struct ResponseAPIContentGetProfileSubscriptionCommunity: Decodable {
    // MARK: - In work API `content.getProfile`
    public let id: String
    public let name: String
    public let avatarUrl: String
}


// MARK: -
public struct ResponseAPIContentGetProfileRegistration: Decodable {
    // MARK: - In work API `content.getProfile`
    public let time: String
}


// MARK: -
public struct ResponseAPIContentGetProfileStat: Decodable {
    // MARK: - In work API `content.getProfile`
    public let postsCount: Int64
}


// MARK: -
public struct ResponseAPIContentGetProfilePersonal: Decodable {
    // MARK: - In work API `content.getProfile`
    public let contacts: ResponseAPIContentGetProfileContact
    public let avatarUrl: String?
    public let coverUrl: String?
    public let biography: String?
}


// MARK: -
public struct ResponseAPIContentGetProfileContact: Decodable {
    // MARK: - In work API `content.getProfile`
    public let facebook: String
    public let telegram: String
    public let whatsApp: String
    public let weChat: String
}


// MARK: -
public struct ResponseAPIContentGetFeedResult: Decodable {
    // MARK: - In work API `content.getFeed`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIContentGetFeed?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIContentGetFeed: Decodable {
    // MARK: - In work API `content.getFeed`
    public let items: [ResponseAPIContentGetFeedItem]?
    public let sequenceKey: String?
}


// MARK: -
public struct ResponseAPIContentGetFeedItem: Decodable {
    // MARK: - In work API `content.getFeed`
    public let content: ResponseAPIContentGetFeedItemContent
    public let votes: ResponseAPIContentGetFeedItemVotes
    public let stats: ResponseAPIContentGetFeedItemStats
    public let payout: ResponseAPIContentGetFeedItemPayout
    public let contentId: ResponseAPIContentGetFeedItemСontentId
    public let meta: ResponseAPIContentGetFeedItemMeta
    public let author: ResponseAPIContentGetFeedItemAuthor?
    public let community: ResponseAPIContentGetFeedItemCommunity
}


// MARK: -
public struct ResponseAPIContentGetFeedItemContent: Decodable {
    // MARK: - In work API `content.getFeed`
    public let body: ResponseAPIContentGetFeedItemContentBody
    public let title: String
}


// MARK: -
public struct ResponseAPIContentGetFeedItemContentBody: Decodable {
    // MARK: - In work API `content.getFeed`
    public let preview: String
}


// MARK: -
public struct ResponseAPIContentGetFeedItemVotes: Decodable {
    // MARK: - In work API `content.getFeed`
    public let hasUpVote: Bool
    public let hasDownVote: Bool
}


// MARK: -
public struct ResponseAPIContentGetFeedItemStats: Decodable {
    // MARK: - In work API `content.getFeed`
    public let wilson: ResponseAPIContentGetFeedItemStatsWilson
    public let commentsCount: UInt64
}


// MARK: -
public struct ResponseAPIContentGetFeedItemStatsWilson: Decodable {
    // MARK: - In work API `content.getFeed`
    public let hot: Double
    public let trending: Double
}


// MARK: -
public struct ResponseAPIContentGetFeedItemPayout: Decodable {
    // MARK: - In work API `content.getFeed`
    public let rShares: UInt64
}


// MARK: -
public struct ResponseAPIContentGetFeedItemСontentId: Decodable {
    // MARK: - In work API `content.getFeed`
    public let userId: String
    public let permlink: String
    public let refBlockNum: UInt64
}


// MARK: -
public struct ResponseAPIContentGetFeedItemMeta: Decodable {
    // MARK: - In work API `content.getFeed`
    public let time: String
}


// MARK: -
public struct ResponseAPIContentGetFeedItemAuthor: Decodable {
    // MARK: - In work API `content.getFeed`
    public let userId: String
    public let username: String
}


// MARK: -
public struct ResponseAPIContentGetFeedItemCommunity: Decodable {
    // MARK: - In work API `content.getFeed`
    public let id: String
    public let name: String
    public let avatarUrl: String?
}
