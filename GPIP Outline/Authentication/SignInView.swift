//
//  SignInView.swift
//  GPIP Outline
//
//  Created by Albert Huynh on 7/19/23.
//

import SwiftUI
import CoreData
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth


@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
         
         try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }

}

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
}

struct SignInView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    @State var showPassword: Bool = false
    
    @Binding var showSignInView: Bool
        
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Background")
                VStack(alignment: .leading, spacing: 20){
//                    
//                    Image("first-aid-image")
//                        .resizable()
//                        .padding()
//                    
                    
                    Text("LOGIN")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text("Email")
                        .font(.title3)
                    HStack{
                        TextField("Ex: yourname@gmail.com", text: $viewModel.email)
                            .padding(20)
                            .background(Color.gray.opacity(0.4))
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 2)
                            }
                        Image(systemName: "person")
                    }
                    
                    //Password
                    Text("Password")
                        .font(.title3)
                    HStack {
                        Group {
                            if showPassword { // when this changes, you show either TextField or SecureField
                                TextField("Enter Password",
                                          text: $viewModel.password,
                                          prompt: Text("Enter Password").foregroundColor(.blue))
                            } else {
                                SecureField("Enter Password",
                                            text: $viewModel.password,
                                            prompt: Text("Enter Password").foregroundColor(.blue))
                            }
                        }
                        .padding(20)
                        .background(Color.gray.opacity(0.4))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                        }
                        
                        Button { // add this new button
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button {
                        Task {
                            do {
                                try await viewModel.signIn()
                                showSignInView = false
                                print("LOGGED IN")
                                
                            } catch {
                                print(error)
                            }
                        }

                    } label: {
                        Text("LOGIN")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Divider()
                        .frame( height: 20.0)
                    
                    VStack{
                        HStack{
                            Text("Need an account?")
                            
                            NavigationLink{
                                SignUpView(showSignInView: $showSignInView)
                            } label: {
                                Text("SIGN UP")
                                    .underline()
                            }
                        }
                        
                        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal))
                        {
                            Task{
                                do{
                                    try await authViewModel.signInGoogle()
                                    showSignInView = false
                                    if showSignInView == false {
                                        print("IT WORKS?")
                                    }
                                    
                                } catch{
                                    print(error)
                                }
                            }
                        }
                        .padding()
                    }
                    
                }.padding()
            }
            
        }
        
        
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignInView(showSignInView: .constant(false))
        }
    }
}
