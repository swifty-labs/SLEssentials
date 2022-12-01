//
//  GoogleCastManager.swift
//  Zina
//
//  Created by Milos Stankovic on 15.9.22..
//

import Foundation
import GoogleCast

typealias VoidReturnClosure<T> = (T) -> ()

public final class GoogleCastManager: NSObject {
	// MARK: - Constants
	
	private enum Constants: Int {
		case imageWidth = 400
		case imageHeight = 600
	}
	
	// MARK: - Properties
	
	private let kReceiverAppID = kGCKDefaultMediaReceiverApplicationID
	private let kDebugLoggingEnabled = true
	
	private var sessionManager: GCKSessionManager?
	private var content: Castable?
	private var currentSession: GCKSession? {
		sessionManager?.currentSession
	}
	public var uiInstance: GCKUIStyle {
		GCKUIStyle.sharedInstance()
	}
	public var onError: VoidReturnClosure<String>?

	// MARK: - Singleton
	
	public static let shared = GoogleCastManager()

	// MARK: - Initialization
	
	override init() {}
	
	// MARK: - Public methods
	
	public func initialize(presentMediaControls present: Bool = true) {
		let criteria = GCKDiscoveryCriteria(applicationID: kReceiverAppID)
		let options = GCKCastOptions(discoveryCriteria: criteria)
		GCKCastContext.setSharedInstanceWith(options)

		GCKLogger.sharedInstance().delegate = self
		sessionManager = GCKCastContext.sharedInstance().sessionManager
		sessionManager?.add(self)
		GCKCastContext.sharedInstance().useDefaultExpandedMediaControls = present
	}

	public func cast(_ content: Castable) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self = self, !self.isCasting(content) else { return }
			self.content = content
			guard self.currentSession?.connectionState == .connected else { return }
			self.loadMedia()
		}
	}
	
	// MARK: - Private methods
	
	private func loadMedia() {
		guard let content = self.content, let url = URL(string: content.videoUrl) else { return }
		let metadata = GCKMediaMetadata()
		metadata.setString("\(content.title)", forKey: kGCKMetadataKeyTitle)
		metadata.setString("\(content.description)", forKey: kGCKMetadataKeySubtitle)
		if let imageUrl = content.imageUrl, let thumbnailURL = URL(string: imageUrl) {
			metadata.addImage(GCKImage(url: thumbnailURL, width: Constants.imageWidth.rawValue, height: Constants.imageHeight.rawValue))
		}
		
		let mediaInfoBuilder = GCKMediaInformationBuilder.init(contentURL: url)
		mediaInfoBuilder.metadata = metadata
		mediaInfoBuilder.mediaTracks = getSubtitles()
		let mediaInformation = mediaInfoBuilder.build()
		
		let options = GCKMediaLoadOptions()
		options.activeTrackIDs = (mediaInfoBuilder.mediaTracks?.count ?? 0) > 0 ? [1] : []
		
		guard let request = currentSession?.remoteMediaClient?.loadMedia(mediaInformation, with: options) else { return }
		request.delegate = self
		
	}
	
	private func isCasting(_ content: Castable) -> Bool {
		guard let currentContent = self.content, currentContent.videoUrl == content.videoUrl else { return false }
		return true
	}
	
	private func getSubtitles() -> [GCKMediaTrack] {
		var tracks = [GCKMediaTrack]()
		var identifier = 1
		content?.subtitles?.forEach { subtitle in
			if let captionTrack = GCKMediaTrack(identifier: identifier, contentIdentifier: subtitle.link, contentType: "text/vtt", type: .text, textSubtype: .captions, name: subtitle.title, languageCode: nil, customData: nil) {
				tracks.append(captionTrack)
				identifier += 1
			}
		}
		return tracks
	}
}

// MARK: - GCKLoggerDelegate
extension GoogleCastManager: GCKLoggerDelegate {}

// MARK: - GCKRequestDelegate
extension GoogleCastManager: GCKRequestDelegate {	
	func request(_ request: GCKRequest, didFailWithError error: GCKError) {
		onError?(error.localizedDescription)
	}
}

// MARK: - GCKSessionManagerListener
extension GoogleCastManager: GCKSessionManagerListener {
	func sessionManager(_ sessionManager: GCKSessionManager, didStart session: GCKSession) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			self?.loadMedia()
		}
	}
	
	func sessionManager(_ sessionManager: GCKSessionManager, didFailToStart session: GCKSession, withError error: Error) {
		onError?(error.localizedDescription)
	}
	
	func sessionManager(_ sessionManager: GCKSessionManager, didFailToStart session: GCKCastSession, withError error: Error) {
		onError?(error.localizedDescription)
	}
}
