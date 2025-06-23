import SwiftUI

struct UserDataView: View {
    @State var viewModel: UserDataViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Hello")
                .font(.largeTitle)
            Text("\(viewModel.firstName) \(viewModel.lastName)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
                .scaleEffect(1.2)
                .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: UUID())
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    UserDataView(viewModel: UserDataViewModel())
}
