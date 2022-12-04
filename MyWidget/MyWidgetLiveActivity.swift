//
//  MyWidgetLiveActivity.swift
//  MyWidget
//
//  Created by Toshiharu Imaeda on 2022/11/30.
//

import ActivityKit
import WidgetKit
import SwiftUI
import MyLiveActivity

struct MyWidgetLiveActivity: Widget {
    /// 輝度が抑えられているかどうか（ダークモード扱いになっているか）
    @Environment(\.isLuminanceReduced) var isLuminanceReduced

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello")
            }
            .activityBackgroundTint(activityBgTint)
            .activitySystemActionForegroundColor(activityFgTint)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    if let data = context.attributes.thumbnail, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.readPages.description)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // more content
                }
            } compactLeading: {
                if let data = context.attributes.thumbnail, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                }
            } compactTrailing: {
                Text(context.state.readPages.description)
            } minimal: {
                if let data = context.attributes.thumbnail, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
//            .keylineTint(Color.red)
//            // カスタムのマージンを指定できる
//            .contentMargins(.all, 8, for: .expanded)
        }
    }

    private var activityBgTint: Color {
        if isLuminanceReduced {
            return .black
        } else {
            return .black
        }
    }

    private var activityFgTint: Color {
        if isLuminanceReduced {
            return .cyan
        } else {
            return .cyan
        }
    }
}
