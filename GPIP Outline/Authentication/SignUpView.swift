//
//  SignUpView.swift
//  GPIP Outline
//
//  Created by Albert Huynh on 7/21/23.
//

import SwiftUI

// SIGN IN EMAIL VIEW

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
         
         try await AuthenticationManager.shared.createUser(email: email, password: password)
    }

    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
         try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }  
}


struct SignUpView: View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    
    //shows the signUpView
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button{
                Task{
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                    
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                }
                
            } label: {
                Text("SIGN UP")
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Create Account")
        Image("LogoHeal'mApp")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .cornerRadius(90)
        Spacer()

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignUpView(showSignInView: .constant(false))
        }
    }
}
