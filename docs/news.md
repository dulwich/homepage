# News

## 1.2.1 (2026-04-29)

Bugfix release. See the [full changelog](https://github.com/dulwich/dulwich/blob/master/NEWS) for details.

## 1.2.0 (2026-04-21)

Highlights:

- Add `am` command and `porcelain.am()` for applying mailbox-style email patches (`git am`), with state persistence for `--continue`, `--skip`, `--abort`, and `--quit`.
- Add `apply` command and `porcelain.apply_patch()` for applying unified diffs, including support for rename/copy detection, binary patches, and `--3way` merge fallback.
- Expanded `log` command options: `--oneline`, `--abbrev-commit`, `--author`, `--grep`, `--since`, `--stat`, `--patch`, `--follow`, and more.
- Add support for push options (`-o`/`--push-option`) and atomic push (`--atomic`).
- Add support for `extensions.relativeworktrees`.
- Several configuration options honoured: `gc.pruneExpire`, `core.precomposeunicode`, `core.gitProxy`, `core.maxStat`, `core.packedGitLimit`, `core.deltaBaseCacheLimit`.
- HTTP client now respects `http.userAgent` configuration.
- Fix client incorrectly sending `unborn` in Git protocol v2 `ls-refs` to servers that don't advertise it (e.g. Gerrit 3.12.2).

## 1.1.0 (2026-02-17)

- Add basic subtree support.
- Implement server-side Git hooks (`pre-receive`, `update`, `post-receive`) in `ReceivePackHandler`.
- Report real-time transfer progress during clone/fetch.
- Add client-side support for Git protocol v2 `packfile-uris` capability.
- Add bundle URI support for faster clones and fetches (`dulwich.bundle_uri`).
- Add `--unshallow` support to the `fetch` command.
- Support `GIT_TRACE_PACKET` in `dulwich.cli`.
- Fix `porcelain.checkout` incorrectly skipping files whose paths start with `.git` (`.github/`, `.gitignore`, etc.).
- Fix cloning of SHA-256 repositories in Git protocol v2.

## 1.0.0 (2026-01-17)

**Dulwich 1.0 is out!**

From this release onwards, Dulwich will not break backwards compatibility until 2.0. Micro releases (1.x.y) are reserved for important bugfixes; major releases (1.x.0) introduce new features without breaking backwards compatibility.

Highlights leading up to 1.0:

- Signature vendor system supporting GPG, SSH signatures, and X.509 certificates.
- Partial clone with object filtering.
- `aiohttp`-based server support (`dulwich.aiohttp`).
- Callback-based HTTP authentication support.
- SHA-256 repository support throughout.

For the full history, see the [NEWS file](https://github.com/dulwich/dulwich/blob/master/NEWS).
