cask "listen-together" do
  version "1.2.5"
  sha256 "0ad2d8430bf3f499b5e6b5bef0d302ef70e0dcf4e40529f6b158d2bee80b3bcd"

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
