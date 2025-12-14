import SwiftUI

struct FloatingLabelTextField: View {
    let title: String
    @Binding var text: String

    var keyboardType: UIKeyboardType = .default
    var rightIcon: Image? = nil
    var onRightIconTap: (() -> Void)? = nil

    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            // рамка
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isFocused ? Color.black.opacity(0.8) : Color.gray.opacity(0.35),
                    lineWidth: 1
                )

            // ЛЕЙБЛ — ВСЕГДА ВИДЕН
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 6)
                .background(Color(.systemBackground))
                .offset(x: 14, y: -22)

            // поле ввода
            HStack(spacing: 10) {
                TextField("", text: $text)
                    .keyboardType(keyboardType)
                    .focused($isFocused)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 14)

                if let rightIcon {
                    Button {
                        onRightIconTap?()
                    } label: {
                        rightIcon
                            .foregroundColor(.secondary)
                            .padding(.trailing, 14)
                    }
                }
            }
        }
        .frame(height: 56)
        .animation(.easeInOut(duration: 0.12), value: isFocused)
    }
}

struct FloatingLabelPasswordField: View {
    let title: String
    @Binding var text: String
    @Binding var showPassword: Bool

    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isFocused ? Color.black.opacity(0.8) : Color.gray.opacity(0.35),
                    lineWidth: 1
                )

            // Лейбл всегда сверху
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 6)
                .background(Color(.systemBackground))
                .offset(x: 14, y: -22)

            HStack(spacing: 10) {
                Group {
                    if showPassword {
                        TextField("", text: $text)
                    } else {
                        SecureField("", text: $text)
                    }
                }
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 14)
                .padding(.vertical, 14)

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.secondary)
                        .padding(.trailing, 14)
                }
            }
        }
        .frame(height: 56)
        .animation(.easeInOut(duration: 0.12), value: isFocused)
    }
}
