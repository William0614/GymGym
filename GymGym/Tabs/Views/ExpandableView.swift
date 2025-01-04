//
//  ExpandableView.swift
//  GymGym
//
//  Created by 김보윤 on 8/25/24.
//

import SwiftUI

struct ExpandableView: View {
    
    @Namespace private var namespace
    @State private var show = false
    
    var thumbnail: ThumbnailView
    var expanded: ExpandedView
    
    var thumbnailViewCornerRadius: CGFloat = 10
    var expandedViewCornerRadius: CGFloat = 10
    
    var body: some View {
        VStack {
            if !show {
                thumbnailView()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            show.toggle()
                        }
                    }
            } else {
                expandedView()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            show.toggle()
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    private func thumbnailView() -> some View {
        VStack {
            thumbnail
                .matchedGeometryEffect(id: "view", in: namespace)
        }
        .mask(
            RoundedRectangle(cornerRadius: thumbnailViewCornerRadius, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        )
    }
    
    @ViewBuilder
    private func expandedView() -> some View {
        VStack {
            expanded
                .matchedGeometryEffect(id: "view", in: namespace)
                .mask(
                    RoundedRectangle(cornerRadius: expandedViewCornerRadius, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                )
        }
    }
}

struct ThumbnailView: View, Identifiable {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}

struct ExpandedView: View, Identifiable {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}

struct ExpandableView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableView(
            thumbnail: ThumbnailView(content: {Text("Thumbnail View")}),
            expanded: ExpandedView(content: {Text("Expanded View")})
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
