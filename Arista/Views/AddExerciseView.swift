import SwiftUI

struct AddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var viewModel: AddExerciseViewModel
    
    var onAdd: (() -> Void)? = nil

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Catégorie", text: $viewModel.category)
                    TextField("Heure de démarrage", text: $viewModel.startTime)
                    TextField("Durée (en minutes)", text: $viewModel.duration)
                    TextField("Intensité (0 à 10)", text: $viewModel.intensity)
                }.formStyle(.grouped)
                Spacer()
                Button("Ajouter l'exercice") {
                    if viewModel.addExercise() {
                        onAdd?()
                        presentationMode.wrappedValue.dismiss()
                    }
                }.buttonStyle(.borderedProminent)
                    
            }
            .navigationTitle("Nouvel Exercice ...")
            
        }
    }
}

#Preview {
    AddExerciseView(viewModel: AddExerciseViewModel(repository: ExerciseRepository()))
}
