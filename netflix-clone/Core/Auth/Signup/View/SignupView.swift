//
//  SignupView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 23/12/25.
//

import SwiftUI

import SwiftUI
import SwiftUINavigation
import ToastUI

struct SignupView: View {
    var authVM: AuthVM
    @Environment(\.authCoordinator) var router
    @Environment(\.toast) var toast
    
    @State var authModel: AuthModel = .init(email: "", password: "")
    
    @State private var showPassword: Bool = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                ZStack {
                    VStack(spacing: 20) {
                        TextField(
                            "",
                            text: $authModel.email,
                            prompt: Text("Email or phone number")
                                .foregroundStyle(.white)
                        )
                        .keyboardType(.emailAddress)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(.buttonGrayDark)
                        .foregroundStyle(.white)
                        .cornerRadius(4)
                        .disabled(authVM.loading)
                        
                        VStack {
                            if(showPassword) {
                                TextField(
                                    "",
                                    text: $authModel.password,
                                    prompt: Text("Password")
                                        .foregroundStyle(.white)
                                )
                                .overlay {
                                    VStack {
                                        Image(systemName: "eye.slash")
                                            .font(.body)
                                            .onTapGesture {
                                                showPassword = false
                                            }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .keyboardType(.emailAddress)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .padding()
                                .background(.buttonGrayDark)
                                .foregroundStyle(.white)
                                .cornerRadius(4)
                                .disabled(authVM.loading)
                            } else {
                                
                                SecureField(
                                    "",
                                    text: $authModel.password,
                                    prompt: Text("Password").foregroundStyle(.white)
                                )
                                .overlay {
                                    VStack {
                                        Image(systemName: "eye")
                                            .font(.body)
                                            .onTapGesture {
                                                showPassword = true
                                            }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.buttonGrayDark)
                                .foregroundStyle(.white)
                                .cornerRadius(4)
                                .disabled(authVM.loading)
                            }
                            
                        }
                        .padding(.bottom)
                        
                        
                        ButtonNetflix(
                            text: "Sign Up",
                            disabled: authVM.loading
                        ) {
                            Task {
                                await authVM
                                    .signup(
                                        formData: authModel,
                                        toast: toast,
                                        router: router
                                    )
                            }
                        }
                        
                        signinBottomSection
                    }
                    
                    if authVM.loading {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

extension SignupView {
    @ViewBuilder
    var signinBottomSection: some View {
        VStack(spacing: 20) {
            Text("OR")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
            HStack(spacing: 0) {
                Text("Already have account? ")
                Button("Sign In") {
                    router.navigateBack()
                }
                .foregroundStyle(.white)
            }
            .foregroundStyle(.white)
            
            VStack {
                Text("Sign in is protected by Google reCAPTCHA to ensure you're not a bot.")
                    .foregroundStyle(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
        }
        
    }
}

#Preview {
    SignupView(authVM: AuthVM(service: AuthService()))
}
