//
//  ContentView.swift
//  AlphaHunt
//
//  Created by Kern Redd on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: AlphaHunt
    @State private var userEntry: String = ""
    @State private var showSettings = false
    @State private var showRules = false
    @State private var showProgress = false
    @State private var showNewGameAlert = false
    @State private var progress = 0.0
    
    var body: some View {
        ZStack {
            backgroundImage
            VStack {
                
                HStack {
                    newGameButton
                    progressBar
                }
                    
                    letterImage
                    userEntryTextField
                
                HStack {
                    skipButton
                    Spacer()
                    okButton
                }
                .padding()
                
                Spacer()
                HStack {
                    settingsButton
                        .padding( .leading)
                    Spacer()
                    rulesButton
                    Spacer()
                    progressButton
                        .padding( .trailing)
                }
                .padding()
            }
            .padding()
        }
    }
    
    @ViewBuilder
    var backgroundImage: some View {
        Image("bck_alt1")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    var letterImage: some View {
        Image("\(viewModel.currentLetter)")
            .resizable()
              .scaledToFit()
              .padding(.top)
              .modifier(ShakeEffect(shakes: viewModel.invalidEntry ? 2 : 0))
            .animation(Animation.linear, value: viewModel.invalidEntry)
    }
    
    @ViewBuilder
    var newGameButton: some View {
        Button {
            showNewGameAlert = true
        } label: {
//            Text("New Game")
            Text("\(Image(systemName: "plus.circle"))")
                .font(Font.largeTitle.weight(.bold))
                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
                    .opacity(0.80)
                )
                .padding(.leading)
                .overlay {
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(.blue, lineWidth: 2)
                }
        }
        .alert("New Game?", isPresented: $showNewGameAlert, actions: {
            Button("OK", role: .destructive) {
                viewModel.newGame(isAlphabetical: viewModel.isAlphabetical)
                progress = 0
            }
            Button("Cancel", role: .cancel) {}
        }, message: {
            Text("Current progress will be lost")
        })
    }
    
    @ViewBuilder
    var okButton: some View {
        Button {
            viewModel.addResponse(response: userEntry, isAlphabetical: viewModel.isAlphabetical)
            progress = viewModel.percentProgress
            userEntry = ""
        } label: {
          Image("buttOK")
            .resizable()
            .scaledToFit()
            .frame(width: 110, height: 110)

                .overlay {
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(.green, lineWidth: 2)
                }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var progressBar: some View {
        HStack {
            Text("\(viewModel.numberCompleted)/26")
                .font(Font.headline.weight(.medium))
            ProgressView(value: progress)
                .scaleEffect(x: 1.0, y: 5.0)
        }

        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .opacity(0.80)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue, lineWidth: 2)
        }
        .onTapGesture {
            showProgress = true
        }
        .padding(.horizontal)

    }
    
    @ViewBuilder
    var progressButton: some View {
        Button {
            showProgress.toggle()
        } label: {
//            Text("Progress")
            Text("\(Image(systemName: "list.bullet.circle.fill"))")
                .font(Font.system(size: 50))
                .foregroundColor(.white)
//                .foregroundColor(.black)
//                .frame(maxWidth: .infinity)
                .background(Circle()
                    .fill(.black)
                    .opacity(0.80)
                )
                                   
        }
        .sheet(isPresented: $showProgress) {
            NavigationView {
                List {
                    ForEach(Array(viewModel.responses.keys.sorted()), id: \.self) { key in
                        Text("\(key): \(viewModel.responses[key] ?? "" )")
                    }
                }.navigationTitle("My Progress: \(viewModel.numberCompleted)/26")
            }
        }
    }
    
    @ViewBuilder
    var rulesButton: some View {
        Button {
            showRules = true
            print("Image tapped!")
        } 
            label: {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
            }
        .sheet(isPresented: $showRules) {
            
            Text("How To Play")
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    Image("rules")
                        .resizable()
                        .scaledToFill()
                }
            }
        }
    }
    
    
    @ViewBuilder
    var settingsButton: some View {
//    func settingsButton() -> some View {
        Button {
            showSettings.toggle()
        } label: {
//            Text("Settings")
            Text("\(Image(systemName: "gearshape.circle.fill"))")
                .font(Font.system(size: 50))
                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
                .background(Circle()
                    .fill(.black)
                    .opacity(0.80)
                )

        }
        .sheet(isPresented: $showSettings) {
                    Text("Settings")
                        .font(Font.largeTitle.weight(.bold))
                        .padding(.top)
                    List {
                        Toggle("Alphabetical order", isOn: $viewModel.isAlphabetical)
                    }
                    .navigationTitle("Settings")
                    .padding(.horizontal)
                    .presentationDetents([.medium])
                }
    }
    
    @ViewBuilder
    var skipButton: some View {
        Button {
//            viewModel.nextLetter(isAlphabetical: viewModel.isAlphabetical, letters: viewModel.letters)
            viewModel.skipLetter(isAlphabetical: viewModel.isAlphabetical, letters: viewModel.letters)
//            viewModel.removeLetter(letter: viewModel.model.currentLetter)
        } label: {
            Image("buttSkip")
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
//                .background(
//                    RoundedRectangle(
//                        cornerRadius: 20
//                    )
//                    .fill(.white)
//                    .opacity(0.80)
//                )
                .overlay {
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(.red, lineWidth: 2)
                }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var userEntryTextField: some View {
        TextField(
            "I spy something that starts with \(viewModel.currentLetter)", text: $userEntry
        )
        .onSubmit {
            viewModel.addResponse(response: userEntry, isAlphabetical: viewModel.isAlphabetical)
            progress = viewModel.percentProgress
            userEntry = ""
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .disableAutocorrection(true)
        .padding(.horizontal)
    }
}

struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: AlphaHunt())
    }
}
