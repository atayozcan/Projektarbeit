actor UserManager {
    func updateProfile() async {
        let preferences = await preferencesManager.getPreferences()
        // Process preferences
    }
}

actor PreferencesManager {
    func getPreferences() async {
        let userInfo = await userManager.getUserInfo()
        // Use userInfo to determine preferences
    }

    func getUserInfo() async {
        // Get info
    }
}
