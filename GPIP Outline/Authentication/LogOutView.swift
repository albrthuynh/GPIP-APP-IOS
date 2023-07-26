//
//  LogOutView.swift
//  GPIP Outline
//
//  Created by Albert Huynh on 7/23/23.
//

import SwiftUI

//SETTINGS VIEW

@MainActor
final class settingsViewModel: ObservableObject{
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
                
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws{
        let email = "123@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "hello123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}

struct LogOutView: View {
    @StateObject private var viewModel = settingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            Button("Log Out"){
                Task{
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                        print("LOGGED OUT")
                    } catch{
                        print(error)
                    }
                }
            }
            
            Button("Reset Password"){
                Task{
                    do {
                        try await viewModel.resetPassword()
                        print("PASSWORD RESET IS RUN")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update Password"){
                Task{
                    do {
                        try await viewModel.updatePassword()
                        print("PASSWORD UPDATE")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update email"){
                Task{
                    do {
                        try await viewModel.updateEmail()
                        print("EMAIL UPDATED")
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct LogOutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LogOutView(showSignInView: .constant(false))
        }
    }
}
