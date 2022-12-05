//
//  MyWidgetLiveActivity.swift
//  MyWidget
//
//  Created by Toshiharu Imaeda on 2022/11/30.
//

import ActivityKit
import WidgetKit
import SwiftUI
import DataModule

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
                    thumbnailImage(context.attributes.thumbnail)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.readPages.description)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // more content
                }
            } compactLeading: {
                HStack {
                    Spacer(minLength: 4)
                    thumbnailImage(context.attributes.thumbnail)?.resizable().aspectRatio(contentMode: .fit)
                }
            } compactTrailing: {
                Text("1/100")
            } minimal: {
                thumbnailImage(context.attributes.thumbnail)
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

    private func thumbnailImage(_ imageFileName: String) -> Image? {
        let defaultImage = Image(systemName: "chevron.right")

        do {
            guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.me.toshi-sv.ActivityKitExample")?.appending(path: imageFileName) else { return defaultImage }
            let data = try Data(contentsOf: url)
            guard let uiImage = UIImage(data: data) else { return defaultImage }
            return Image(uiImage: uiImage)
        } catch(let e) {
            print(e.localizedDescription)
        }
        
        return defaultImage
    }
}
