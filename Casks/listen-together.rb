cask "listen-together" do
  version "1.1.0"
  sha256 "e89a5ecf5025021ea37c4267d7430b44cfe0917c519db2e07aa3e66199185e34"

  url "https://github.com/uifi95/listen-together/releases/download/v#{version}/ListenTogether-#{version}-macos.zip"
  name "ListenTogether"
  desc "Listen to the same song at the same time across Qobuz and Apple Music"
  homepage "https://github.com/uifi95/listen-together"

  depends_on macos: :sonoma
  # Creating a room opens a Cloudflare quick tunnel.
  depends_on formula: "cloudflared"

  app "ListenTogether.app"

  # The app is signed ad hoc, not notarized: without this, Gatekeeper blocks
  # the downloaded copy until it's allowed in System Settings.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/ListenTogether.app"]
  end

  zap trash: [
    "~/Library/Preferences/app.listentogether.mac.plist",
  ]
end
