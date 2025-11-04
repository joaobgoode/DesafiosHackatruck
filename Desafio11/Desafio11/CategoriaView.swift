import SwiftUI
import AVFoundation
import Translation


struct CategoriaView: View {
    
    let categoria: Categoria
    let synthesizer = AVSpeechSynthesizer()
    @State private var isExpanded: Bool = false
    @State var text = ""
    @State var showTranslation = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
                HStack(spacing: 15) {
                    if let url = URL(string: categoria.image) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                                .shadow(radius: 2)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 50, height: 50)
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    Text(categoria.nome)
                        .font(.headline)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isExpanded.toggle()
                            }
                        }
                    
                    Spacer()
                    
                    Button {
                        let utterance = AVSpeechUtterance(string: categoria.nome)
                        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                        utterance.rate = 0.45
                        synthesizer.speak(utterance)
                    } label: {
                        Image(systemName: "speaker.wave.2.fill")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    
                    
                    Button {
                        text = categoria.nome
                        showTranslation.toggle()
                    } label: {
                        Image(systemName: "translate")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                }
            .padding()
            .translationPresentation(isPresented: $showTranslation, text: text)

            if isExpanded{
                
                ForEach(Array(categoria.subcategorias.enumerated()), id: \.offset) { index, subcat in
                    CategoriaView(categoria: subcat)
                }
                .padding(.horizontal)
                
                ForEach(Array(categoria.itens.enumerated()), id: \.offset) { index, item in
                    HStack(spacing: 15) {
                        if let url = URL(string: item.image) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                                    .shadow(radius: 2)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        
                        Text(item.nome)
                            .font(.headline)
                        
                        Spacer()
                        
                        Button {
                            let utterance = AVSpeechUtterance(string: item.nome)
                            utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                            utterance.rate = 0.45
                            synthesizer.speak(utterance)
                        } label: {
                            Image(systemName: "speaker.wave.2.fill")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button {
                            text = item.nome
                            showTranslation.toggle()
                        } label: {
                            Image(systemName: "translate")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    }

                }
                .padding(.horizontal)
            }
        }
    }
}

