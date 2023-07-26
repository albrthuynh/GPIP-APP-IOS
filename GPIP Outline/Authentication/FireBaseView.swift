////
////  FireBaseView.swift
////  GPIP Outline
////
////  Created by Albert Huynh on 7/21/23.
////
//
//import SwiftUI
//import Firebase
//import GoogleSignIn
//import GoogleSignInSwift
//import FirebaseAuth
//
////AUTHENTICATION VIEW
//
////@MainActor
////final class AuthenticationViewModel: ObservableObject {
////
////    func signInGoogle() async throws{
////        let helper = SignInGoogleHelper()
////        let tokens = try await helper.signIn()
////        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
////    }
////
////}
//
//struct FireBaseView: View {
//
//
//    @StateObject private var viewModel = AuthenticationViewModel()
//
//    @Binding var showSignInView: Bool
//
//
//    var body: some View {
//        VStack{
//            HStack{
//                Text("Need an account?")
//
//                NavigationLink{
//                    SignUpView(showSignInView: $showSignInView)
//                } label: {
//                    Text("SIGN UP")
//                        .underline()
//                }
//            }
//
//            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal))
//            {
//                Task{
//                    do{
//                        try await viewModel.signInGoogle()
//                        showSignInView = false
//                        if showSignInView == false {
//                            print("IT WORKS?")
//                        }
//
//                    } catch{
//                        print(error)
//                    }
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct FireBaseView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            FireBaseView(showSignInView: .constant(false))
//        }
//    }
//}
