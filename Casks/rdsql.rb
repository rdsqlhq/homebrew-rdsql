cask "rdsql" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.0"
  sha256 arm:   "4e310266936d013cf19f4ce6c83d179d52663f73506d1b0c73448709d8811c3c",
         intel: "ef0e58e3de70d7d021e9ae75e81e6de20f4457e957f6f863d77dab419fd46bee"

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
