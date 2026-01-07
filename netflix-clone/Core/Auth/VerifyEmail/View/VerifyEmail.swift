//
//  SigninView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 23/12/25.
//

import SwiftUI
import SwiftUINavigation
import ToastUI

struct VerifyEmail: View {
    var authVM: AuthVM
    var email: String
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
                ZStack {
                    VerificationField(
                        type: .six,
                        isInValid: $isInvalid,
                        isLoading: authVM.loading,
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
                    
                    if authVM.loading {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                    }
                }
                
                HStack {
                    if authVM.timeRemaining == 0 {
                        Text("Resend code.")
                            .font(.headline)
                            .foregroundStyle(.white)
                        Button("Resend") {
                            Task {
                                await authVM.resendCode(email: email)
                            }
                        }
                        .foregroundStyle(
                            !authVM.canResend ? .white.opacity(0.5) : .white
                        )
                        .disabled(!authVM.canResend)
                    } else {
                        Text("Resend code in \(authVM.timeRemaining)s.")
                            .font(.headline)
                            .foregroundStyle(.white)
                        Button("Resend") {
                            Task {
                                await authVM.resendCode(email: email)
                            }
                        }
                        .font(.title3)
                        .foregroundStyle(
                            !authVM.canResend ? .white.opacity(0.5) : .white
                        )
                        .disabled(!authVM.canResend)
                    }
                }
                .padding(.top, 30)
                
                ButtonNetflix(
                    text: authVM.loading ? "Please wait" : "Verify",
                    configuration: .init(
                        backgroundColor: authVM.loading ? .red
                            .opacity(0.5) : .red,
                    ),
                ) {
                    Task {
                        await authVM.verifyEmail(
                            email: email,
                            code: code,
                            toast: toast,
                            onFailed: { value in
                                isInvalid = !isInvalid
                            },
                            router: router
                        )
                    }
                }
                .padding(.top, 40)
            }
            .padding(.horizontal)
        }
        .onAppear {
            authVM.startTimer()
        }
        .onDisappear {
            authVM.stopTimer()
        }
    }
}


#Preview {
    VerifyEmail(authVM: AuthVM(service: AuthService()), email: "")
}

