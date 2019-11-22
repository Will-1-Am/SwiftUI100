//
//  SendAndReceiveCodable.swift
//  CupcakeCorner
//
//  Created by William Spanfelner on 11/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct SendAndReceiveCodable: View {
    @State var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    func loadData() {
        // Create the URL to read from.
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        // Wrap the url in a URLRequest - this can be customised if necessary
        let request = URLRequest(url: url)
        
        //Stat a networking session with the URLRequest just created.
        /*
         "URLSession is the iOS class responsible for managing network requests. You can make your own session if you want to, but it’s very common to use the shared session that iOS creates for us to use – unless you need some specific behavior, using the shared session is fine."
         */
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    //we have good data - go back to the main thread
                    DispatchQueue.main.async {
                        //update UI
                        self.results = decodedResponse.results
                    }
                    
                    //everything is good so time to exit
                    return
                }
            }
            //if still here, there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}



struct SendAndReceiveCodable_Previews: PreviewProvider {
    static var previews: some View {
        SendAndReceiveCodable()
        .environment(\.colorScheme, .dark)
    }
}
