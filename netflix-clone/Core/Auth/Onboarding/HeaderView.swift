//
//  HeaderView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 28/12/25.
//

import SwiftUI



struct HeaderView: View {
    @State private var selectedSheet: SheetType?
    
    var textColor: Color = .white
    var isPrivacy: Bool = false
    
    init(textColor: Color, isPrivacy: Bool = true) {
        self.textColor = textColor
        self.isPrivacy = isPrivacy
    }
    
    var body: some View {
        HStack {
            NetflixLogoView()
            Spacer()
            InformationLinks(textColor: textColor)
            
        }
        
    }
}

extension HeaderView {
    @ViewBuilder
    var loginBtn: some View {
        Button {
            
        } label: {
            Text("Sign In")
                .foregroundStyle(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 8)
                .fontWeight(.semibold)
        }
        .background(.gray)
        .clipShape(.rect(cornerRadius: 4))
    }
}

#Preview {
    HeaderView(textColor: .white)
}

