//
//  AuthentiactionManager.swift
//  NoteBox
//
//  Created by Laryokkk on 27/06/23.
//

import Foundation
import FirebaseAuth

//struct AuthModel {
//    let uid: String
//    let email: String?
//    let photoURL: String?
//
//    init(user: User) {
//        self.uid = user.uid
//        self.email = user.email
//        self.photoURL = user.photoURL?.absoluteString
//    }
//}

final class AuthenticationManager {
//
//    static let shared = AuthenticationManager()
//
//    private init() { }
//
//    @discardableResult
//    func signUp(email: String, password: String) async throws -> AuthModel {
//        let auth = try await Auth.auth().createUser(withEmail: email, password: password)
//
//        return AuthModel(user: auth.user)
//    }
//
//    @discardableResult
//    func signIn(email: String, password: String) async throws -> AuthModel {
//        let auth = try await Auth.auth().signIn(withEmail: email, password: password)
//
//        return AuthModel(user: auth.user)
//    }
//
//    // checks locally if there is authenticated user
//    func getAuthenticatedUser() throws -> AuthModel {
//        guard let user = Auth.auth().currentUser else {
//            throw URLError(.badServerResponse)
//        }
//
//        return AuthModel(user: user)
//    }
//
//    func signOut() throws {
//        try Auth.auth().signOut()
//    }
    
//    private func signUp() {
//        Task {
//            do {
//                let userData = try await AuthenticationManager.shared.signUp(email: "test@gmail.com", password: "box123")
//                print("Success sign un")
//                print(userData)
//            } catch {
//                print("Error: \(error)")
//            }
//        }
//    }
//
//    private func signIn() {
//        Task {
//            do {
//                let userData = try await AuthenticationManager.shared.signIn(email: "test@gmail.com", password: "box123")
//                print("Success sign in")
//                print(userData)
//            } catch {
//                print("Error: \(error)")
//            }
//        }
//    }
//
//    private func signOut() {
//        Task {
//            do {
//                try AuthenticationManager.shared.signOut()
//                print("Success sign out")
//            } catch {
//                print(error)
//            }
//        }
//    }
//
//    private func isSigned() -> Bool{
//        let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
//
//        return authUser == nil
//    }
}
