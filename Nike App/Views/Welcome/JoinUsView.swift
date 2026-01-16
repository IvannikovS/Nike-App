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

                    FloatingLabelTextField(
                        title: "Code",
                        text: $code,
                        keyboardType: .numberPad,
                        rightIcon: Image(systemName: "arrow.clockwise")
                    ) {
                        //
                    }
                    
                    HStack(spacing: 12) {
                        FloatingLabelTextField(title: "First name", text: $firstName)
                        FloatingLabelTextField(title: "Surname", text: $surname)
                    }

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
}

#Preview("Join Us Content") {
    JoinUsSheet(
        onCancel: {},
        onContinue: {}
    )
}

