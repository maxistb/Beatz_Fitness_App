//
//  Login.swift
//  Beatz Fitness
//
//  Created by Maximillian Stabe on 23.04.23.
//


import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginVM = LoginViewModel(loginHandler: LoginHanlderMock())
    
    var body: some View {
        VStack {
            LoginImage()
            LoginInput(loginVM: loginVM)
                .frame(maxWidth: 350)
        }
    }
}

private struct LoginInput: View {
    
    @ObservedObject var loginVM: LoginViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            UsernameTextField(username: $loginVM.username)
            PasswordTextField(password: $loginVM.password)
            if loginVM.hasError {
                ErrorBoxView(error: loginVM.error)
            }
            HStack {
                if loginVM.biometricAuthenticationAvailable {
                    Button(action: {
                        let error = loginVM.biometricLogin()
                        appState.isLoggedId = error == .none
                    }) {
                        BiometricButtonView(biometricType: loginVM.biometricType)
                            .padding(.leading)
                    }
                }
                Spacer()
                Button(action: {
                    let error = loginVM.login()
                    appState.isLoggedId = error == .none
                }) {
                    LoginText()
                        .padding(.trailing)
                }
            }
        }
        .padding()
        .neumorphismStyle()
        .padding()
    }
}

private struct BiometricButtonView: View {
    var biometricType: BiometricType
    
    var body: some View {
        HStack {
            Image(systemName: biometricType.getIconName)
                .resizable()
                .frame(width: 40, height: 40)
            Text(biometricType.getText)
        }
    }
}

private struct LoginText: View {
    
    var body: some View {
        Text("Anmelden")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .cornerRadius(15)
    }
}

private struct LoginImage: View {
    
    var body: some View {
        Image("BeatzLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

private struct UsernameTextField: View {
    
    @Binding var username: String
    
    var body: some View {
        HStack {
            Image(systemName: "person")
            TextField("Benutzername", text: $username)
                .padding(.leading, 10)
        }
        .padding()
        .padding(.horizontal)
    }
}

private struct PasswordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
            SecureField("Passwort", text: $password)
                .padding(.leading, 10)
        }
        .padding()
        .padding(.horizontal)
    }
}

private struct ErrorBoxView: View {
    
    var error: LoginError
   
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle.fill")
            Text(error.description)
        }
        .foregroundColor(.red)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
