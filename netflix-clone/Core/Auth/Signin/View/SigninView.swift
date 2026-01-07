//
//  SigninView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 23/12/25.
//

import SwiftUI
import SwiftUINavigation
import ToastUI

struct SigninView: View {
    let authVM: AuthVM
    @State var authModel = AuthModel(email: "", password: "")
    @Environment(\.authCoordinator) var router
    @Environment(\.toast) var toast
    
    @State private var showPassword: Bool = false
    @State private var forgotPassword: Bool = false
    
    
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
                            
                            
                            Button("Forgot Password?") {
                                forgotPassword = true
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 8)
                        }
                        .padding(.bottom)
                        
                        
                        ButtonNetflix(
                            text: "Sign In",
                            disabled: authVM.loading
                        ) {
                            Task {
                                await authVM
                                    .signin(formData: authModel, toast: toast)
                            }
                        }
                        
                        loginBottomSection
                    }
                    .opacity(authVM.loading ? 0.5 : 1)
                    if authVM.loading {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .padding(.horizontal)
        }
        .dialog(
            config: .init(
                cornerRadius: 4,
                dismissOnBackgroundTap: false
            ),
            isPresented: $forgotPassword
        ) {
            VStack {
                TextField(
                    "",
                    text: .constant(""),
                    prompt: Text("Email")
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
                
                ButtonNetflix(text: "Continue") {
                    print("Signing in...")
                    
                    forgotPassword = false
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .padding(.horizontal)
        }
    }
    
    
}

extension SigninView {
    @ViewBuilder
    var loginBottomSection: some View {
        VStack(spacing: 20) {
            Text("OR")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
            HStack(spacing: 0) {
                Text("Don't have account? ")
                Button("Signup") {
                    router.push(.signup)
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
    SigninView(authVM: AuthVM(service: AuthService()))
}
