cask "rdsql" do
  arch arm: "aarch64", intel: "x64"

  version "1.3.0"
  sha256 arm:   "63b926cb2146826d393a57f4ff7498c390a0b883c83f27dbbda8778e0591a6de",
         intel: "9e655e1d14014aa2a794293384942a972e55bfcef6ddafb7a03e07f937e83c81"

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
