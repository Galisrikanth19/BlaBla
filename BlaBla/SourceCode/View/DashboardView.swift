//
//  DashboardView.swift
//  Created by GaliSrikanth on 06/05/25.

import SwiftUI

struct DashboardView: View {
    @State private var phoneNum = ""
    //ViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Text("fullName")
                    .background(Color.gray.opacity(0.6))
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity)
                Text("\(viewModel.currentUser?.fullName ?? "")")
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            }
            
            
            VStack(alignment: .leading) {
                Text("Email")
                    .background(Color.gray.opacity(0.6))
                    .padding(.top, 30)
                Text("\(viewModel.currentUser?.email ?? "")")
            }
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            }
            
            
            VStack(alignment: .leading) {
                Text("Uid")
                    .background(Color.gray.opacity(0.6))
                    .padding(.top, 30)
                Text("\(viewModel.currentUser?.uid ?? "")")
            }
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            }
            
            
            TextField("PhoneNumber", text: $phoneNum)
                .textFieldStyle(.roundedBorder)
            
            Button {
                if phoneNum.isEmpty == false {
                    Task {
                        await viewModel.updateUserData(phoneNum)
                    }
                }
            } label: {
                Text("Update")
                    .font(.headline)
                    .fontWeight(.medium)
                    .frame(height: 42)
                    .frame(maxWidth: .infinity)
                    .background(.teal, in: .rect(cornerRadius: 20))
                    .foregroundStyle(.white)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    Task {
                        await logout()
                    }
                }
            }
        }
    }
    
    private func logout() async {
        await viewModel.signOut()
        presentationMode.wrappedValue.dismiss()
    }
}
