cask "listen-together" do
  version "1.0.0"
  sha256 "3c2efe52722cfb308fd7ee00e3dcaa3e4250217e5225e69b3e420454014215b3"

  url "https://github.com/uifi95/listen-together/releases/download/v#{version}/ListenTogether-#{version}-macos.zip"
  name "ListenTogether"
  desc "Listen to the same song at the same time across Qobuz and Apple Music"
  homepage "https://github.com/uifi95/listen-together"

  depends_on macos: ">= :sonoma"
  # Creating a room opens a Cloudflare quick tunnel.
  depends_on formula: "cloudflared"

  app "ListenTogether.app"

  # The app is signed ad hoc, not notarized: without this, Gatekeeper blocks
  # the downloaded copy until it's allowed in System Settings.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ListenTogether.app"]
  end

  zap trash: [
    "~/Library/Preferences/app.listentogether.mac.plist",
  ]
end
