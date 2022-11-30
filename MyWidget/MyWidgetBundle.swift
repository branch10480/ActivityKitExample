//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by Toshiharu Imaeda on 2022/11/30.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyWidget()
        MyWidgetLiveActivity()
    }
}
