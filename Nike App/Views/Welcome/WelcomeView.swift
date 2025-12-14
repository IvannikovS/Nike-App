import SwiftUI

struct WelcomeView: View {
    let onContinue: () -> Void
    
    @State private var showJoinsheet = false
    
    var body: some View {
        let background = ZStack {
            Image("Screen5BackgroundImage")
                .resizable()
                .scaledToFill()
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black, Color.black.opacity(0.0)]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .padding(.top, 287)
        }
        .ignoresSafeArea()
        
        let logo = Image("NikeLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
        
        let title = Text("Nike App")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
        
        let description = Text("Bringing Nike Members\nthe best products,\ninspiration and stories\nin sport.")
            .font(.body)
            .multilineTextAlignment(.leading)
            .foregroundColor(.white)
            .lineSpacing(4)
        
        let joinUsButton = Button("Join Us") {
            showJoinsheet = true
        }
        .font(.headline)
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.white)
        .cornerRadius(25)
        
        let signInButton = Button("Sign In") {
            onContinue()
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.white, lineWidth: 2)
        )
        
        let textBlock = VStack(alignment: .leading, spacing: 24) {
            logo
            VStack(alignment: .leading, spacing: 16) {
                title
                description
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 50)
        
        let buttonsBlock = HStack(spacing: 16) {
            joinUsButton
            signInButton
        }

        let mainContainer = VStack(spacing: 0) {
            textBlock
            Color.clear.frame(height: 50)
            buttonsBlock
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        
        return ZStack {
            background
            mainContainer
        }
        .sheet(isPresented: $showJoinsheet) {
            JoinUsSheet(
                onCancel: { showJoinsheet = false},
                onContinue: {
                    showJoinsheet = false
                    onContinue()
                }
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    WelcomeView(onContinue: {})
}
