//
//  ContentView.swift
//  Desafio07
//
//  Created by Turma01-8 on 27/10/25.
//

import SwiftUI

struct Song : Identifiable {
    var id: Int
    var title : String
    var artist : String
    var cover : String = "https://placehold.co/50x50"
    
    func show() -> some View{
        HStack {
            AsyncImage(url: URL(string: cover)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
            } placeholder: {
                Color.gray.opacity(0.3)
                    .frame(width: 50, height: 50)
            }
            VStack(alignment: .leading){
                Text(title)
                Text(artist)
                Spacer()
            }
            .frame(width: 200, alignment: .leading)
            Spacer()
            Image(systemName: "ellipsis")
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    func showDetails() -> some View {
        VStack {
            AsyncImage(url: URL(string: cover)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
            } placeholder: {
                Color.gray.opacity(0.3)
                    .frame(width: 200, height: 200)
            }
            Text(title)
                .font(.system(size: 24))
            Text(artist)
        }
        .frame(width: 200)
        
    }
}


struct Playlist {
    var id: Int
    var title: String
    var author: String
    var image: String
    var songs: [Song]
    
    init(id: Int, title: String, author: String, image: String, songs: [Song]) {
        self.id = id
        self.title = title
        self.author = author
        self.image = image
        self.songs = songs
    }
    
    func showSugestion() -> some View {
        VStack {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
            } placeholder: {
                Color.gray.opacity(0.3)
                    .frame(width: 200, height: 200)
            }
            Text(title)
        }
        .frame(width: 200)
        
    }
}



struct ContentView: View {
    
    @State var playlist: Playlist
    @State var sugestoes: [Playlist]
    
    
    init(playlist: Playlist, sugestoes: [Playlist]) {
        self._playlist = State(initialValue: playlist)
        
        self._sugestoes = State(initialValue: sugestoes)
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .black, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                ScrollView{
                    
                    VStack{
                        AsyncImage(url: URL(string: playlist.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipped()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                                .frame(width: 200, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .padding(.top, 50)
                        .padding(.bottom, 20)
                        
                        Text(playlist.title)
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            AsyncImage(url: URL(string: playlist.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .clipped()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                                    .frame(width: 20, height: 20)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            Text(playlist.author)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)
                        
                        
                        .padding(.bottom, 20)
                        VStack{
                            ForEach(playlist.songs.indices, id: \.self) { i in
                                NavigationLink(destination: SongView(playlist: playlist, number: i)) {
                                    playlist.songs[i].show()
                                }
                                .buttonStyle(PlainButtonStyle())                            }
                        }
                        .padding(.bottom, 50)
                        
                        Text("Sugeridos")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 5) {
                                ForEach(sugestoes, id: \.id) { sugestao in
                                    Button(action: {
                                        var novasSugestoes: [Playlist] = [playlist]
                                        
                                        for s in sugestoes {
                                            if s.id != sugestao.id {
                                                novasSugestoes.append(s)
                                            }
                                        }
                                        sugestoes = novasSugestoes
                                        
                                        playlist = sugestao
                                    }) {
                                        sugestao.showSugestion()
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    
                }
                .foregroundColor(.white)
                
            }
        }
        .tint(.white)
    }
}

#Preview {
    ContentView(playlist: Playlist(
        id: 1,
        title: "HackaFM",
        author: "HackaSong",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlQBojmTIKspyiherUEmNC67y289D2lsUhtA&s",
        songs: [
            Song(id: 1, title: "Construção", artist: "Chico Buarque", cover: "https://m.media-amazon.com/images/I/617Q0HKVpKL._UF1000,1000_QL80_.jpg"),
            Song(id: 2, title: "Águas de Março", artist: "Elis Regina & Tom Jobim", cover: "https://www.jobim.org/jobim/bitstream/handle/2010/12798/elisetomcapa.jpg?sequence=2"),
            Song(id: 3, title: "Carinhoso", artist: "Pixinguinha", cover: "https://discosdampb.music.blog/wp-content/uploads/2020/02/carinhoso.jpg"),
            Song(id: 4, title: "Asa Branca", artist: "Luiz Gonzaga", cover: "https://i.scdn.co/image/ab67616d0000b2739bfaa02a01c3a16185dac256"),
            Song(id: 5, title: "Mas Que Nada", artist: "Jorge Ben Jor", cover: "https://i.scdn.co/image/ab67616d0000b2732daa87c238a78a680511da3c"),
            Song(id: 6, title: "Chega de Saudade", artist: "João Gilberto", cover: "https://i.discogs.com/F39hdf22uxH9349jkC4CW2Ba-JSYdcz_8OVdK_xXeiw/rs:fit/g:sm/q:40/h:300/w:300/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTEzMzg1/ODMwLTE1NTMyMTM1/MTQtNTY1Ny5qcGVn.jpeg"),
            Song(id: 7, title: "Panis et Circensis", artist: "Os Mutantes", cover: "https://i.scdn.co/image/ab67616d0000b273cf5f9eaa0d3a164305c35b49"),
            Song(id: 8, title: "Detalhes", artist: "Roberto Carlos", cover: "https://upload.wikimedia.org/wikipedia/pt/4/4e/Roberto_Carlos_-_Detalhes.jpg"),
            Song(id: 9, title: "Canto de Ossanha", artist: "Baden Powell & Vinicius de Moraes", cover: "https://upload.wikimedia.org/wikipedia/pt/1/1f/Baden_Powell_e_Vinicius_de_Moraes_-_Canto_de_Ossanha.jpg"),
            Song(id: 10, title: "Alegria, Alegria", artist: "Caetano Veloso", cover: "https://upload.wikimedia.org/wikipedia/pt/6/6e/Caetano_Veloso_-_Alegria%2C_Alegria.jpg")
        ]
    ),
                sugestoes: [
                    Playlist(id: 2, title: "1 - One", author: "One", image: "https://media.istockphoto.com/id/1416797815/pt/foto/golden-number-one.jpg?s=612x612&w=0&k=20&c=jzRNxzR93QdH17awotIdQJmLH6YBWzCgoIEpZinv0Lo=",
                             songs: []),
                    Playlist(id: 3, title: "2 - Two", author: "Two", image: "https://www.shutterstock.com/shutterstock/photos/1890767737/display_1500/stock-photo--d-render-number-two-glowing-in-the-dark-pink-blue-neon-light-1890767737.jpg",
                             songs: []),
                    Playlist(id: 4, title: "3 - Three", author: "Three", image: "https://www.shutterstock.com/shutterstock/photos/1890767731/display_1500/stock-photo--d-render-number-three-glowing-in-the-dark-pink-blue-neon-light-1890767731.jpg",
                             songs: []),
                    Playlist(id: 5, title: "4 - Four", author: "Four", image: "https://www.creativefabrica.com/wp-content/uploads/2022/01/31/4-Number-four-Fire-Alphabet-Letters-png-Graphics-24406161-1-1-580x387.jpg",
                             songs: []),
                ])}
