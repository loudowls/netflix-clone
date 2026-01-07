//
//  Profile.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct Profile: View {
    @State var authVM: AuthVM
    @State var selectedItem: PhotosPickerItem?
    @State var imageData: Data?
    
    var body: some View {
        ZStack {
            Color.darkProfileBG
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Edit Profile")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                ZStack(alignment: .bottomTrailing) {
                    
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                    
                    // Image
                    if let imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 60))
                    } else if let imageURL = authVM.user?.avatarUrl {
                        KFImage(URL(string: imageURL))
                            .placeholder {
                                ProgressView()
                                    .tint(.white)
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 60))
                    } else {
                        // Placeholder
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.white)
                    }
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                            .overlay {
                                Image(systemName: "pencil")
                            }
                    }
                    .padding(.bottom, -10)
                    .padding(.trailing, -10)
                }
                
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: .init(lineWidth: 0.5))
                    .frame(height: 90)
                    .foregroundStyle(.white.opacity(0.3))
                    .overlay {
                        VStack(alignment: .leading) {
                            Text("Profile Name")
                                .foregroundStyle(.secondary)
                            TextField(
                                "",
                                text: Binding(get: {
                                    $authVM.wrappedValue.user?.fullName ?? ""
                                }, set: { value in
                                    $authVM.wrappedValue.user?.fullName = value
                                }),
                                prompt: Text("John Doe").foregroundStyle(
                                    .white.opacity(0.5)
                                )
                            )
                            .font(.title)
                            .foregroundStyle(.white)
                        }
                        .padding(20)
                    }
                
                VStack(spacing: 12) {
                    ButtonNetflix(
                        text: "Save",
                        configuration: .init(
                            backgroundColor: .white,
                            textConfiguration: .init(
                                font: .headline,
                                fontWeight: .bold,
                                foregroundColor: .black
                            )
                        ),
                        action: {
                            if let user = authVM.user {
                                Task {
                                    await authVM
                                        .updateProfile(
                                            formData: user
                                        )
                                }
                            }
                            
                        }
                    )
                    
                    ButtonNetflix(
                        text: "Sign Out",
                        configuration: .init(
                            backgroundColor: .netflixRed,
                            textConfiguration: .init(
                                font: .headline,
                                fontWeight: .bold
                            )
                        ),
                        action: {
                            Task {
                                await authVM.signout()
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 40)
            
            if authVM.loading {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.5))
            }
        }
        .onChange(of: selectedItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                    imageData = data
                    await authVM.uploadProfileImage(image: data)
                }
            }
        }
    }
}

#Preview {
    Profile(authVM: AuthVM(service: AuthService()))
}
