import SwiftUI

struct AddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var viewModel: AddExerciseViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Picker("Catégorie", selection: $viewModel.category) {
                        ForEach(viewModel.categories, id: \ .self) { cat in
                            Text(cat)
                        }
                    }
                    DatePicker("Heure de démarrage", selection: $viewModel.selectedTime, displayedComponents: .hourAndMinute)
                        .onChange(of: viewModel.selectedTime) {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "HH:mm"
                            viewModel.startTime = formatter.string(from: viewModel.selectedTime)
                        }
                    TextField("Durée (en minutes)", text: $viewModel.duration)
                        .keyboardType(.numberPad)
                    VStack(alignment: .leading) {
                        Text("Intensité : \(Int(viewModel.intensityDouble))")
                        Slider(value: $viewModel.intensityDouble, in: 0...10, step: 1) {
                            Text("Intensité")
                        }
                        .onChange(of: viewModel.intensityDouble) {
                            viewModel.intensity = String(Int(viewModel.intensityDouble))
                        }
                    }
                }.formStyle(.grouped)
                Spacer()
                Button("Ajouter l'exercice") {
                    if viewModel.addExercise() {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.isFormValid)
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
            }
            .navigationTitle("Nouvel Exercice ...")
        }
    }
}

#Preview {
    AddExerciseView(viewModel: AddExerciseViewModel())
}
