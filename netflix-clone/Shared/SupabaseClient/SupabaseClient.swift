//
//  SupabaseClient.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import Foundation
import Supabase


let clientSupabase = SupabaseClient(
    supabaseURL: URL(string: "https://kllnijbbvjlnkikwpjkr.supabase.co")!,
    supabaseKey: "sb_publishable_CIeA1YlSIsH6NXzf9QEQIg_kWIs1fZV",
    options: SupabaseClientOptions(
        auth: .init(emitLocalSessionAsInitialSession: true)
    )
    
)
