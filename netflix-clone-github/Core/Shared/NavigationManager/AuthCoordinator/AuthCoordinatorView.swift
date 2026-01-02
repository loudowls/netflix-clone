//
//  AuthCoordinatorView.swift
//  netflix-clone-github
//
//  Created by Pardip Bhatti on 02/01/26.
//

import SwiftUI
import SwiftUINavigation

struct AuthCoordinatorView: View {
    var body: some View {
        CoordinatorView(
            environmentKeyPath: \.authCoordinator) {
                SignIn()
                    .navigationBarBackButtonHidden()
                    .toolbar {
//                        ToolbarItem(placement: .topBarLeading) {
//                            BackButton()
//                        }
//                        .sharedBackgroundVisibility(.hidden)
//                        
                        ToolbarItem(placement: .principal) {
                            NetflixLogoView()
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            InformationLinks(textColor: .white, isPrivacy: false)
                        }
                        .sharedBackgroundVisibility(.hidden)
                    }
            } destinationBuilder: { destination in
                switch destination {
                case .signin:
                    SignIn()
                        .navigationBarBackButtonHidden()
                        .toolbar {
//                            ToolbarItem(placement: .topBarLeading) {
//                                BackButton()
//                            }
//                            .sharedBackgroundVisibility(.hidden)
                            
                            ToolbarItem(placement: .principal) {
                                NetflixLogoView()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                InformationLinks(textColor: .white, isPrivacy: false)
                            }
                            .sharedBackgroundVisibility(.hidden)
                        }
                case .signup:
                    Signup()
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                NetflixLogoView()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                InformationLinks(textColor: .white, isPrivacy: false)
                            }
                            .sharedBackgroundVisibility(.hidden)
                        }
                    
                case .verifyEmail:
                    VerifyEmail()
                        .toolbar {
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
    }
}

#Preview {
    AuthCoordinatorView()
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
