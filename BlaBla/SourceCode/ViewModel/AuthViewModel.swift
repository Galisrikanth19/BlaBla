//
//  AuthViewModel.swift
//  Created by GaliSrikanth on 06/05/25.

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: LocalUser?
    @Published var isError: Bool = false
    
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    init() {
        
    }
}

// MARK: - Login -
extension AuthViewModel {
    func checkIfUserLoggedIn() async -> Bool {
        if auth.currentUser != nil {
            userSession = auth.currentUser
            await getUserDetails(userSession?.uid ?? "")
            return true
        }
        
        return false
    }
    
    func loginUser(email: String, password: String) async {
        do {
            let authResult = try await auth.signIn(withEmail: email,
                                                   password: password)
            userSession = authResult.user
            print("loggedIn successfully")
            await getUserDetails(userSession?.uid ?? "")
        } catch {
            isError = true
        }
    }
    
    private func getUserDetails(_ uid: String) async {
        do {
            let document = try await firestore.collection("users").document(uid).getDocument()
            currentUser = try document.data(as: LocalUser.self)
            dump(currentUser)
        } catch {
            isError = true
        }
    }
}

// MARK: - Register -
extension AuthViewModel {
    func createUser(email: String, fullName: String, password: String) async {
        do {
            let authResult = try await auth.createUser(withEmail: email, password: password)
            await createUserInFirestore(uid: authResult.user.uid, email: email, fullName: fullName)
        } catch {
            isError = true
        }
    }
    
    private func createUserInFirestore(uid: String, email: String, fullName: String) async {
        let user = LocalUser(uid: uid,
                             email: email,
                             fullName: fullName)
        do {
            try firestore.collection("users").document(uid).setData(from: user)
        } catch {
            isError = true
        }
    }
}

// MARK: - SignOut -
extension AuthViewModel {
    func signOut() async {
        do {
            try auth.signOut()
        } catch {
            isError = true
        }
    }
}

// MARK: - UpdateDetails -
extension AuthViewModel {
    func updateUserData(_ phNum: String) async {
        let userDocumentRef = firestore.collection("users").document(currentUser?.uid ?? "")
        let dataToUpdate: [String: Any] = [
            "phoneNum": phNum
        ]
        do {
            try await userDocumentRef.updateData(dataToUpdate)
        } catch {
            
        }
    }
}
