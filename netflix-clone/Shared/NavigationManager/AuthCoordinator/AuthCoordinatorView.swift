//
//  AuthCoordinatorView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 23/12/25.
//

import SwiftUI
import SwiftUINavigation

struct AuthCoordinatorView: View {
    @State var authVM: AuthVM
    var body: some View {
        CoordinatorView(
            environmentKeyPath: \.authCoordinator,
            rootView: {
                OnboardingView()
            },
            destinationBuilder: { destination in
                switch destination {
                case .onboarding:
                    OnboardingView()
                case .signin:
                    SigninView(authVM: authVM)
                        .navigationBarBackButtonHidden()
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                BackButton()
                            }
                            .sharedBackgroundVisibility(.hidden)
                            
                            ToolbarItem(placement: .principal) {
                                NetflixLogoView()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                InformationLinks(textColor: .white, isPrivacy: false)
                            }
                            .sharedBackgroundVisibility(.hidden)
                        }
                case .signup:
                    SignupView(authVM: authVM)
                        .navigationBarBackButtonHidden()
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                BackButton()
                            }
                            .sharedBackgroundVisibility(.hidden)
                            
                            ToolbarItem(placement: .principal) {
                                NetflixLogoView()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                InformationLinks(textColor: .white, isPrivacy: false)
                            }
                            .sharedBackgroundVisibility(.hidden)
                        }
                case .verifyEmail(let email):
                    VerifyEmail(authVM: authVM, email: email)
                        .navigationBarBackButtonHidden()
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                BackButton()
                            }
                            .sharedBackgroundVisibility(.hidden)
                            
                            ToolbarItem(placement: .principal) {
                                NetflixLogoView()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                InformationLinks(textColor: .white, isPrivacy: false)
                            }
                            .sharedBackgroundVisibility(.hidden)
                        }
                }
            }
        )
    }
}

struct BackButton: View {
    @Environment(\.authCoordinator) var coordinator
    
    var body: some View {
        Button {
            
            coordinator.navigateBack()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundStyle(.white)

        }

    }
}
