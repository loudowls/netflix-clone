//
//  VerifyEmail.swift
//  netflix-clone-github
//
//  Created by Pardip Bhatti on 02/01/26.
//

import SwiftUI

struct VerifyEmail: View {
//    var email: String
    @Environment(\.authCoordinator) var router
    @Environment(\.toast) var toast
    
    @State var isInvalid: Bool = false
    @State var code: String = ""
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(
                        red: 0.0,
                        green: 0.0,
                        blue: 0.0
                    ),
                    Color(
                        red: 0.2431372549,
                        green: 0.0,
                        blue: 0.0
                    ),
                    Color(
                        red: 0.2431372549,
                        green: 0.0,
                        blue: 0.0
                    ),
                    Color(
                        red: 0.0,
                        green: 0.0,
                        blue: 0.0
                    ),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                VerificationField(
                    type: .six,
                    isInValid: $isInvalid,
                    isLoading: false,
                    onChange: { value in
                    },
                    onComplete: { value in
                        print("final value", value)
                        // api call here
                        code = value
                    },
                    configuration: .init(
                        colors: .init(
                            typing: .white,
                            active: .white,
                            valid: .green,
                            invalid: .red,
                            text: .white,
                            loadingText: .white.opacity(0.5)
                        ),
                        sizes: .init(
                            spacing: 10,
                        )
                    )
                )
            }
            
        }
    }
}

#Preview {
    VerifyEmail()
}
