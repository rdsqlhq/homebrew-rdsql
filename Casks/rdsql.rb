cask "rdsql" do
  arch arm: "aarch64", intel: "x64"

  version "1.1.11"
  sha256 arm:   "3703b8a568bcf8b02ab5145a81390ac961ffddc306e193d75e4e14974b2d7be9",
         intel: "0d33bbfbfb5954120f9bcdb9ce4387c9d30793239c7b772481f5493fc2230568"

  url "https://rdsql.com/download/rdSQL_#{version}_#{arch}.dmg"
  name "rdSQL Desktop"
  desc "Native database workspace for PostgreSQL, MySQL, SQLite, DuckDB, MongoDB, Redis, and S3-compatible object storage"
  homepage "https://rdsql.com"

  livecheck do
    url "https://rdsql.com/download"
    regex(/Current version:\s*v?(\d+(?:\.\d+)+)/i)
  end

  app "rdSQL.app"

  postflight do
    # macOS builds aren't code-signed yet (see rdsql-desktop RELEASE.md), so
    # Gatekeeper quarantines the app and refuses to launch it after a plain
    # DMG install. Homebrew installs bypass the manual "xattr -cr" workaround
    # by clearing the quarantine flag here automatically.
    system_command "/usr/bin/xattr",
                    args: ["-cr", "#{appdir}/rdSQL.app"],
                    sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.rdsql.desktop",
    "~/Library/Caches/com.rdsql.desktop",
    "~/Library/Preferences/com.rdsql.desktop.plist",
    "~/Library/Saved Application State/com.rdsql.desktop.savedState",
  ]
end
