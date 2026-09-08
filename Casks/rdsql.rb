cask "rdsql" do
  arch arm: "aarch64", intel: "x64"

  version "1.1.9"
  sha256 arm:   "aab84611b76af47bb742f53f055b3b72623a1a66b9e9e1bc859c0033d4c3f66b",
         intel: "a425ca95564dd1d9786377fc30abec5304ce040e5792ef4aa378f8a0d473c87b"

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
