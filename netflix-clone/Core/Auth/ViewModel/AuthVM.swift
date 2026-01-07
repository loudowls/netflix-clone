//
//  AuthVM.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import Foundation
import ToastUI
import Supabase
import SwiftUINavigation
import Combine

@Observable
class AuthVM {
    var service: AuthServiceProtocol
    var user: ProfileModel?
    var isAuthenticated: Bool = false
    var loading: Bool = false
    
    var timeRemaining: Int = 60
    var canResend: Bool = true
    var isTimerRunning: Bool = false
    
    private var timerTask: Task<Void, Never>?
    
    init(service: AuthServiceProtocol) {
        self.service = service
        
        Task {
            await listenAuthChanges()
        }
    }
    
    func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
        isTimerRunning = false
    }
        
    
    func startTimer() {
        guard !isTimerRunning else { return }
        
        timeRemaining = 60
        isTimerRunning = true
        canResend = false
        
        timerTask = Task {
            while timeRemaining > 0 && !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                timeRemaining -= 1
            }
            
            if !Task.isCancelled {
                isTimerRunning = false
                canResend = true
            }
        }
    }
    
    func listenAuthChanges() async {
        for await (event, session) in clientSupabase.auth.authStateChanges {
            switch event {
            case .initialSession:
                if let session, !session.isExpired {
                    await getProfile(id: "\(session.user.id)")
                    self.isAuthenticated = true
                } else {
                    self.isAuthenticated = false
                    self.user = nil
                }
            case .signedIn:
                
                if let session, !session.isExpired {
                    await getProfile(id: "\(session.user.id)")
                    self.isAuthenticated = true
                }
            case .signedOut:
                self.isAuthenticated = false
                self.user = nil
            default: break
            }
        }
    }
    
    func signin(formData: AuthModel, toast: ToastManager) async {
        do {
            self.loading = true
            defer { self.loading = false }
            try await service.signin(formData: formData)
            toast
                .success(
                    title: "Welcom to Netflix",
                    backgroundColor: .netflixRed
                )
        } catch {
            if let error = error as? AuthErrors {
                toast.error(title: "Authentication Error", message: error.sbError)
            }
        }
    }
    
    func signup(formData: AuthModel, toast: ToastManager, router: AuthCoordinator) async {
        do {
            self.loading = true
            defer { self.loading = false }
            try await service.signup(formData: formData)
            router.push(.verifyEmail(email: formData.email))
        } catch {
            if let error = error as? AuthErrors {
                toast.error(title: "Authentication Error", message: error.sbError)
            }
        }
    }
    
    func verifyEmail(
        email: String,
        code: String,
        toast: ToastManager,
        onFailed: @escaping (_ value: Bool) -> Void,
        router: AuthCoordinator
    ) async {
        do {
            self.loading = true
            defer { self.loading = false }
            try await service.verifyEmail(email: email, code: code)
            toast.success(title: "🎉 Email verified successfully")
            router.navigateToRoot()
        } catch  {
            onFailed(true)
            if let error = error as? AuthErrors {
                toast.error(title: "Authentication Error", message: error.sbError)
            }
        }
    }
    
    func resendCode(email: String) async {
        do {
            self.loading = true
            defer { self.loading = false }
            try await service.resendOTP(email: email)
            startTimer()
        } catch  {
            if let error = error as? AuthErrors {
                print(error.sbError)
            }
        }
    }
    
    func getProfile(id: String) async {
        do {
            user = try await service.getCurrentUser(for: id)
        } catch  {
            if let error = error as? AuthErrors {
                print(error.sbError)
            }
        }
    }
    
    func updateProfile(formData: ProfileModel) async {
        guard let userID = user?.id else {
            return
        }
 
        self.loading = true
        defer { self.loading = false }

        do {
            try await service.updateProfile(for: formData, id: "\(userID)")
        } catch {
            if let error = error as? AuthErrors {
                print(error.sbError)
            }
        }
    }
    
    func uploadProfileImage(image: Data) async {
        self.loading = true
        defer { self.loading = false }
        do {
            let url = try await service.uploadProfileImage(image: image)
            user?.avatarUrl = url
            if let user = user {
                await updateProfile(formData: user)
            }
            
        } catch  {
            if let error = error as? AuthErrors {
                print(error.sbError)
            }
        }
    }
    
    func checkIsAuthenticated() {
        isAuthenticated = service.isSignedIn()
    }
    
    func signout() async {
        do {
            try await service.logout()
            self.isAuthenticated = false
            self.user = nil
        } catch  {
            if let error = error as? AuthErrors {
                print(error.sbError)
            }
        }
    }
    
}
