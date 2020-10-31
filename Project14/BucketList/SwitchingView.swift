//
//  SwitchingView.swift
//  BucketList
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct SwitchingView: View {
    
    enum LoadingState {
        case loading, success, failed
    }
    
    var loadingState = LoadingState.loading
    
    struct LoadingView: View {
        var body: some View {
            Text("Loading…")
                .foregroundColor(Color.white)
        }
    }
    
    struct SuccessView: View {
        var body: some View {
            Text("Success!")
            .foregroundColor(Color.white)
        }
    }
    
    struct FailedView: View {
        var body: some View {
            Text("Failed.")
            .foregroundColor(Color.white)
        }
    }
    
    var body: some View {
        ZStack {
            if Bool.random() {
                Rectangle()
            } else {
                Circle()
            }
//        }
//
//        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct SwitchingView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingView()
    }
}
