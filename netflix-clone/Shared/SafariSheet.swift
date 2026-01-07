//
//  SafariSheet.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 26/12/25.
//

import SwiftUI
import SafariServices

struct SafariSheet: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
