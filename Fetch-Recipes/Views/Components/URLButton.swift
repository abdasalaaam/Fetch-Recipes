//
//  URLButton.swift
//  Fetch-Recipes
//
//  Created by Abud Salem on 10/7/24.
//

import SwiftUI

struct TitleView: View {
    let title: String
    let onLongPress: () -> Void

    var body: some View {
        Text(title)
            .font(.headline)
            .gesture(
                LongPressGesture()
                    .onEnded { _ in
                        onLongPress()
                    }
            )
    }
}
