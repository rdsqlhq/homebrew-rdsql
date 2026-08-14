cask "rdsql" do
  arch arm: "aarch64", intel: "x64"

  version "1.1.3"
  sha256 arm:   "c66931f2a5bc54c0f66e5d25aa9a8228aeb030238a8d2ae0aefb4e60f93730a0",
         intel: "6167d8144c0145b264d74807f5497894b83e42f0973571f22d91d193ef4d42af"

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
    # `cp`/DMG install. Homebrew installs bypass the manual `xattr -cr`
    # workaround by clearing the quarantine flag here automatically.
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
