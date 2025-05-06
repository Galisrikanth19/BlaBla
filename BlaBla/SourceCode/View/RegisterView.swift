//
//  RegisterView.swift
//  Created by GaliSrikanth on 06/05/25.

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    //ViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Please complete all information to create an account.")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            
            TextField("FullName", text: $fullName)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.createUser(email: email,
                                               fullName: fullName,
                                               password: password)
                }
            } label: {
                Text("CreateAccount")
                    .font(.headline)
                    .fontWeight(.medium)
                    .frame(height: 42)
                    .frame(maxWidth: .infinity)
                    .background(.teal, in: .rect(cornerRadius: 20))
                    .foregroundStyle(.white)
            }
            
            
            Spacer()
                .frame(height: 50)
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
