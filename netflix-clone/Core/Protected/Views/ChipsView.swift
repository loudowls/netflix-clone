//
//  ChipsView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import SwiftUI

struct ChipsView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    init(title: String, isSelected: Bool, action: @escaping () -> Void = {}) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(isSelected ? .black : .white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.white : Color.clear)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.white, lineWidth: isSelected ? 0 : 0.5)
                )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    ChipsView(title: "Shows", isSelected: true, action: {})
}
