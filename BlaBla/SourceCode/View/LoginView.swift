//
//  LoginView.swift
//  BlaBla
//
//  Created by GaliSrikanth on 06/05/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToRegister: Bool = false
    @State private var navigateToDashboard: Bool = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Image("LoginHeader")
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 1)
                    }
                    
                Text("Let's Connect With US!")
                    .font(.title)
                    .fontDesign(.rounded)
                
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        Task {
                            await viewModel.loginUser(email: email,
                                                       password: password)
                            navigateToDashboard = true
                        }
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .fontWeight(.medium)
                            .frame(height: 42)
                            .frame(maxWidth: .infinity)
                            .background(.teal, in: .rect(cornerRadius: 20))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                
                SeparatorView()
                
                Button {
                    navigateToRegister = true
                } label: {
                    Text("Register")
                        .font(.headline)
                        .fontWeight(.medium)
                        .frame(height: 42)
                        .frame(maxWidth: .infinity)
                        .background(.teal, in: .rect(cornerRadius: 20))
                        .foregroundStyle(.white)
                }
            }
        }
        .ignoresSafeArea()
        .padding()
        .onAppear {
            Task {
                if await viewModel.checkIfUserLoggedIn() {
                    navigateToDashboard = true
                }
            }
        }
        .navigationDestination(isPresented: $navigateToRegister) {
            RegisterView()
                .environmentObject(viewModel)
        }
        .navigationDestination(isPresented: $navigateToDashboard) {
            DashboardView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    RegisterView()
}

struct SeparatorView: View {
    var body: some View {
        HStack {
            DividerView()
            
            Text("or")
            
            DividerView()
        }
    }
    
    // Private nested view
    private struct DividerView: View {
        var body: some View {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.5))
                .offset(CGSizeMake(0, 3))
        }
    }
}
