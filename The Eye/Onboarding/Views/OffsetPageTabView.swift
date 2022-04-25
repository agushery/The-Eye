//
//  OffsetPageTabView.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import SwiftUI

struct OffsetPageTabView<Content: View> : UIViewRepresentable {
    
    var content: Content
    @Binding var offset: CGFloat
    //@Binding var title: String
    
    func makeCoordinator() -> Coordinator {
        return OffsetPageTabView.Coordinator(parent: self)
    }
    
    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping ()->Content){
        self.content = content()
        self._offset = offset
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        
        // extracting SwiftUI View and embedding into UIkit Scroll View
        let hostView = UIHostingController(rootView: content)
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        // clearing BG
        hostView.view.backgroundColor = .clear
        
        let contraints = [
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            // if using vertical paging and dont declare height contraint
            hostView.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]
        
        scrollView.addSubview(hostView.view)
        scrollView.addConstraints(contraints)
        
        // enable paging
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        // setting delegate
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // need to update only when offset changed manually
        let currentView = uiView.contentOffset.x
        if currentView != offset {
            print("Slide")
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        } else {
            print("Stop")
        }
    }
    
    // pager offset
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var  parent: OffsetPageTabView
        
        init(parent: OffsetPageTabView){
            self.parent = parent
        }//init
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            parent.offset = offset
        }
        
    } // class coordinator
}
