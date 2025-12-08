actor UserManager {
    let preferencesManager: PreferencesManager

    init(preferencesManager: PreferencesManager) {
        self.preferencesManager = preferencesManager
    }

    func updateProfile() async {
        // This will call PreferencesManager, which in turn calls UserManager's method, creating a deadlock
        print("UserManager: Calling getPreferences...")
        let preferences = await preferencesManager.getPreferences()  // Line A
        print("UserManager: Profile updated with preferences: \(preferences)")
    }

    func getUserInfo() async -> String {
        // Simulate fetching user info
        return "User Info"
    }
}

actor PreferencesManager {
    func getPreferences() async -> String {
        // This calls back to UserManager's method, causing a deadlock
        print("PreferencesManager: Calling getUserInfo...")
        let userInfo = await userManager.getUserInfo()  // Line B
        return "Preferences based on \(userInfo)"
    }

    func getUserInfo() async -> String {
        // This function is waiting on getPreferences() which already called getUserInfo()
        return "User Info"
    }
}

// Instantiate actors
let preferencesManager = PreferencesManager()
let userManager = UserManager(preferencesManager: preferencesManager)

// This will attempt to run in a Task but will deadlock
Task {
    await userManager.updateProfile()  // This will lead to a deadlock
}
