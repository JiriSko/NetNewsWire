//
//  ArticleFetcherType.swift
//  Account
//
//  Created by Maurice Parker on 11/13/19.
//  Copyright © 2019 Ranchero Software, LLC. All rights reserved.
//

import Foundation

public protocol SidebarItemIdentifiable {
	var sidebarItemID: SidebarItemIdentifier? { get }
}

public enum SidebarItemIdentifier: CustomStringConvertible, Hashable, Equatable {
	
	case smartFeed(String) // String is a unique identifier
	case script(String) // String is a unique identifier
	case webFeed(String, String) // accountID, webFeedID
	case folder(String, String) // accountID, folderName
	
	public var description: String {
		switch self {
		case .smartFeed(let id):
			return "smartFeed: \(id)"
		case .script(let id):
			return "script: \(id)"
		case .webFeed(let accountID, let webFeedID):
			return "feed: \(accountID)_\(webFeedID)"
		case .folder(let accountID, let folderName):
			return "folder: \(accountID)_\(folderName)"
		}
	}
	
	public var userInfo: [AnyHashable: AnyHashable] {
		switch self {
		case .smartFeed(let id):
			return [
				"type": "smartFeed",
				"id": id
			]
		case .script(let id):
			return [
				"type": "script",
				"id": id
			]
		case .webFeed(let accountID, let webFeedID):
			return [
				"type": "feed",
				"accountID": accountID,
				"webFeedID": webFeedID
			]
		case .folder(let accountID, let folderName):
			return [
				"type": "folder",
				"accountID": accountID,
				"folderName": folderName
			]
		}
	}
	
	public init?(userInfo: [AnyHashable: AnyHashable]) {
		guard let type = userInfo["type"] as? String else { return nil }
		
		switch type {
		case "smartFeed":
			guard let id = userInfo["id"] as? String else { return nil }
			self = SidebarItemIdentifier.smartFeed(id)
		case "script":
			guard let id = userInfo["id"] as? String else { return nil }
			self = SidebarItemIdentifier.script(id)
		case "feed":
			guard let accountID = userInfo["accountID"] as? String, let webFeedID = userInfo["webFeedID"] as? String else { return nil }
			self = SidebarItemIdentifier.webFeed(accountID, webFeedID)
		case "folder":
			guard let accountID = userInfo["accountID"] as? String, let folderName = userInfo["folderName"] as? String else { return nil }
			self = SidebarItemIdentifier.folder(accountID, folderName)
		default:
			return nil
		}
	}

}
