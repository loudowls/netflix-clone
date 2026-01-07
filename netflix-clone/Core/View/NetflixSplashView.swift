//
//  SplashView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 26/12/25.
//

import SwiftUI

struct NetflixSplashView: View {
    @State private var isAnimating = false
    @State var scale: CGFloat = 1.0
    @State var opacity: Double = 0
    
    @Binding var isActive: Bool
    
    let letters = Array("NETFLIX")

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            HStack {
                ForEach(letters.enumerated(), id: \.offset) {
                    index,
                    letter in
                    Text(String(letter))
                        .font(.system(size: 60, weight: .semibold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.9, green: 0.05, blue: 0.05),
                                    Color(red: 0.6, green: 0.0, blue: 0.0)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .scaleEffect(isAnimating ? 1.0 : 0.3)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .animation(
                            .spring(
                                response: 0.6,
                                dampingFraction: 0.8
                            ).delay(Double(index) * 0.1),
                            value: isAnimating
                        )
                }
            }
            .scaleEffect(scale)
            .opacity(opacity)
            
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.3)) {
                opacity = 1.0
            }
            
            withAnimation {
                isAnimating = true
            }
            
            // Hold and fade out
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeOut(duration: 0.9)) {
                    scale = 1.5
                    opacity = 0
                    Task {
                        try await Task.sleep(nanoseconds: 300_000_000)
                        isActive = false
                    }
                    
                }
            }
            
        }
    
    }

}


#Preview {
    NetflixSplashView(isActive: .constant(false))
}
