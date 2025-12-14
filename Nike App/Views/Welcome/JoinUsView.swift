import SwiftUI

struct JoinUsSheet: View {
    let onCancel: () -> Void
    let onContinue: () -> Void

    @State private var code: String = ""
    @State private var firstName: String = ""
    @State private var surname: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var birthDate: Date = Date()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    Image("NikeLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(.top, 8)

                    Text("Now let's make you a\nNike Member.")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("We’ve sent a code to your email.")
                        .foregroundColor(.secondary)

                    // Code
//                    TextField("Code", text: $code)
//                        .keyboardType(.numberPad)
//                        .textInputAutocapitalization(.never)
//                        .padding(14)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.35)))
                    FloatingLabelTextField(
                        title: "Code",
                        text: $code,
                        keyboardType: .numberPad,
                        rightIcon: Image(systemName: "arrow.clockwise")
                    ) {
                        // resend code, если понадобится
                    }

                    // First name + Surname
                    HStack(spacing: 12) {
//                        TextField("First name", text: $firstName)
//                            .padding(14)
//                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.35)))
//
//                        TextField("Surname", text: $surname)
//                            .padding(14)
//                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.35)))
                        FloatingLabelTextField(title: "First name", text: $firstName)
                        FloatingLabelTextField(title: "Surname", text: $surname)
                    }

                    // Password with eye button
//                    HStack {
//                        Group {
//                            if showPassword {
//                                TextField("Password", text: $password)
//                            } else {
//                                SecureField("Password", text: $password)
//                            }
//                        }
//                        .textInputAutocapitalization(.never)
//
//                        Button {
//                            showPassword.toggle()
//                        } label: {
//                            Image(systemName: showPassword ? "eye.slash" : "eye")
//                                .foregroundColor(.secondary)
//                        }
//                    }
//                    .padding(14)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.35)))
                    FloatingLabelPasswordField(
                        title: "Password",
                        text: $password,
                        showPassword: $showPassword
                    )

                    VStack(alignment: .leading, spacing: 6) {
                        Label("Minimum of 8 characters", systemImage: "checkmark")
                            .font(.footnote)
                            .foregroundColor(.green)
                        Label("Uppercase, lowercase letters and one number", systemImage: "checkmark")
                            .font(.footnote)
                            .foregroundColor(.green)
                    }
                    .padding(.top, 4)

                    DatePicker("Date of Birth", selection: $birthDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding(14)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.35)))

                    Text("Get a Nike Member Reward on your birthday.")
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    // Bottom continue button
                    Button {
                        onContinue()
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.black)
                            .cornerRadius(26)
                    }
                    .disabled(false)
                    .padding(.top, 10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .navigationTitle("accounts.nike.com")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { onCancel() }
                }
            }
        }
    }

//    private var canContinue: Bool {
//        // минимальная валидация, чтобы кнопка не была всегда активной
//        code.trimmingCharacters(in: .whitespacesAndNewlines).count >= 4 &&
//        firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false &&
//        surname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false &&
//        password.count >= 8
//    }
}

#Preview("Join Us Content") {
    JoinUsSheet(
        onCancel: {},
        onContinue: {}
    )
}

