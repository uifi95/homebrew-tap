cask "listen-together" do
  version "1.2.0"
  sha256 "1b328fca7e01ca59c4d12c26196f831a144e187a64c4915ff3ae938f10a1ad1b"

  url "https://github.com/uifi95/listen-together/releases/download/v#{version}/ListenTogether-#{version}-macos.zip"
  name "ListenTogether"
  desc "Listen to the same song at the same time across Qobuz and Apple Music"
  homepage "https://github.com/uifi95/listen-together"

  depends_on macos: :sonoma

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
