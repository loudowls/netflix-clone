//
//  AuthService.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import Foundation
import Supabase
import SwiftUI


protocol AuthServiceProtocol {
    func signin(formData: AuthModel) async throws
    func signup(formData: AuthModel) async throws
    func verifyEmail(email: String, code: String) async throws
    func resendOTP(email: String) async throws
    func getCurrentUser(for id: String?) async throws -> ProfileModel?
    func updateProfile(for formData: ProfileModel, id: String) async throws
    func uploadProfileImage(image: Data) async throws -> String?
    func isSignedIn() -> Bool
    func logout() async throws
}

struct AuthService: AuthServiceProtocol {
    func signin(formData: AuthModel) async throws {
        do {
            try await clientSupabase.auth
                .signIn(email: formData.email, password: formData.password)
        } catch {
            throw error as? AuthErrors ?? .supbaseErrors(error)
        }
    }
    
    func signup(formData: AuthModel) async throws {
        do {
            try await clientSupabase.auth
                .signUp(email: formData.email, password: formData.password)
        } catch {
            throw error as? AuthErrors ?? .supbaseErrors(error)
        }
    }
    
    func verifyEmail(email: String, code: String) async throws {
        do {
            try await clientSupabase.auth
                .verifyOTP(
                    email: email,
                    token: code,
                    type: .email,
                )
            
        } catch {
            throw error as? AuthErrors ?? .supbaseErrors(error)
        }
    }
    
    func resendOTP(email: String) async throws {
        do {
            try await clientSupabase.auth.resend(email: email, type: .signup)
        } catch  {
            throw error as? AuthErrors ?? .supbaseErrors(error)
        }
    }
    
    func getCurrentUser(for id: String?) async throws -> ProfileModel? {
        guard let id else {
            throw AuthErrors.unkonwnUserID
        }
        
        do {
            let users: [ProfileModel] = try await clientSupabase
                .from(SBTables.profile.rawValue)
                .select()
                .eq("id", value: id)
                .execute()
                .value
            return users.first
        } catch {
            throw error as? AuthErrors ?? .supbaseErrors(error)
        }
    }
    
    func updateProfile(for formData: ProfileModel, id: String) async throws {
        print(formData, id)
        do {
            try await clientSupabase.from(SBTables.profile.rawValue)
                .update(formData)
                .eq("id", value: id).execute().value
        } catch  {
            throw error as? AuthErrors ?? .supbaseErrors(error)
        }
    }
    
    func uploadProfileImage(image: Data) async throws -> String? {
        let bucketName = "profiles"
        let fileName = UUID().uuidString + ".jpg"
        let filePath = "public/\(fileName)"
        
        do {
            _ = try await clientSupabase.storage
                .from(bucketName)
                .upload(filePath, data: image)
            
            let publicURL = try clientSupabase.storage
                .from(bucketName)
                .getPublicURL(path: filePath)
            
            
            return publicURL.absoluteString
        } catch  {
            throw error as? AuthErrors ?? .supbaseErrors(error)
        }
        
    }
    
    func isSignedIn() -> Bool {
        clientSupabase.auth.currentUser != nil
    }
    
    func logout() async throws {
        do {
            try await clientSupabase.auth.signOut()
        } catch {
            throw error as? AuthErrors ?? .supbaseErrors(error)
        }
    }
}


enum SBTables {
    case profile
    
    var rawValue: String {
        switch self {
        case .profile:
            return "profiles"
        }
    }
}
