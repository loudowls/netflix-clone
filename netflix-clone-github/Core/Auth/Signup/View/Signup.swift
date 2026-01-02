//
//  Signup.swift
//  netflix-clone-github
//
//  Created by Pardip Bhatti on 02/01/26.
//

import SwiftUI
import SwiftUINavigation


struct Signup: View {
    @Environment(\.authCoordinator) var authCoordinator
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 20) {
                TextField(
                    "",
                    text: $email,
                    prompt: Text("Email or phone number")
                        .foregroundStyle(.white)
                )
                .keyboardType(.emailAddress)
                .frame(maxWidth: .infinity)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
                .background(.darkGray)
                .foregroundStyle(.white)
                .cornerRadius(4)
                
                if showPassword {
                    TextField(
                        "",
                        text: $password,
                        prompt: Text("Password")
                            .foregroundStyle(.white)
                    )
                    .overlay {
                        VStack {
                            Button {
                                showPassword = false
                            } label: {
                                Image(systemName: "eye.slash")
                            }

                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .keyboardType(.emailAddress)
                    .frame(maxWidth: .infinity)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.darkGray)
                    .foregroundStyle(.white)
                    .cornerRadius(4)
                } else {
                    SecureField(
                        "",
                        text: $password,
                        prompt: Text("Password").foregroundStyle(.white)
                    )
                    .overlay {
                        VStack {
                            Button {
                                showPassword = true
                            } label: {
                                Image(systemName: "eye")
                            }

                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(maxWidth: .infinity)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.darkGray)
                    .foregroundStyle(.white)
                    .cornerRadius(4)
                }
                
                HStack {
                    Button("Forgot Password?") {
                        
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                ButtonNetflix(text: "SIGN UP") {
                    authCoordinator.push(.verifyEmail)
                }
                .padding(.top)
                
                Text("OR")
                    .foregroundStyle(.white.opacity(0.5))
                
                HStack {
                    Text("Already have an account?")
                    Button("Sign In") {
                        
                        authCoordinator.navigateBack()
                    }
                }
                .foregroundStyle(.white)
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    Signup()
}
