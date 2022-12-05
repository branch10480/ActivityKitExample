//
//  LiveActivity.swift
//  MyLiveActivity
//
//  Created by Toshiharu Imaeda on 2022/12/05.
//

import Foundation
import ActivityKit

public struct MyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        public var readPages: Int

        public init(readPages: Int) {
            self.readPages = readPages
        }
    }

    // Fixed non-changing properties about your activity go here!
    public var thumbnail: String

    public init(thumbnail: String) {
        self.thumbnail = thumbnail
    }
}

