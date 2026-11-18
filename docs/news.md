# News

## 1.2.21 (2026-11-04)

Security and bugfix release:

- Refuse `porcelain.submodule_update` when the submodule path or one of its parents is already a symlink.
- Strip terminal control bytes from sideband messages sent by a remote, so a hostile server can no longer inject ANSI escape sequences into the user's terminal.
- Refuse to open pack indexes whose fanout claims more objects than the file can hold.
- New `sha1dc` extra (`pip install dulwich[sha1dc]`) for detecting SHA-1 collisions.
- Cap tree traversal depth at `core.maxTreeDepth`.
- Honour `protocol.<name>.allow` for submodule URLs; the file transport is now refused for submodules by default.

## 1.2.20 (2026-10-26)

- Parse repeated or out of place commit and tag headers the same way git does, so a commit with two `tree` headers no longer checks out a different tree than git.
- Validate object ids in LFS server batch requests.
- Refuse pushes to ref names outside `refs/` (such as `HEAD`) in `receive-pack`.
- Add `PySequoiaSignatureVendor` for signing and verifying OpenPGP signatures with pysequoia.
- Verify commit signatures against the raw commit, and support `gpgsig-sha256` for SHA-256 repositories.
- Fix fetching into a shallow clone over protocol v2, which could leave the remote ref pointing at missing objects.
- Report the remote's stderr when an ssh connection closes early.

## 1.2.19 (2026-10-22)

Bugfix release. Keeps the assume-unchanged flag on index entries, avoids quadratic behaviour when walking the commit graph, and fixes several issues with interactive rebase, `format-patch` and work tree updates through symlinked directories.

## 1.2.18 (2026-10-11)

- Add support for Python 3.15.
- Many fixes to checkout, reset, pull and merge, in particular around `.gitattributes`, line ending conversion and sparse checkouts.
- Sparse-checkout patterns are now matched like git does.
- Faster `porcelain.status` and `porcelain.add`, particularly on Windows.
- Large overhaul of LFS support: `lfs_fetch`, `lfs_pull` and `lfs_push` now work like their git-lfs counterparts, uploads honour proxy and TLS settings, and all LFS failures raise `LFSError`.
- Fix a race in `GitFile` that could let two writers update the same file concurrently.

## 1.2.17 (2026-10-03)

Define `__all__` in all modules, deprecate a few names that were importable from the wrong module, and restore `dulwich.index.SHA1Reader` and `SHA1Writer` as deprecated aliases.

## 1.2.16 (2026-10-03)

- Many fixes to patch application: binary patches (including `delta` patches), mode-only changes, quoted file names and missing trailing newlines.
- Security fixes for path validation in sparse checkout, mixed reset and LFS, and for `apply_patches` writing through symlinks.
- Record merge conflicts in the index and write `MERGE_HEAD`/`MERGE_MSG`, so `git commit` can finish a merge started by dulwich.
- Report conflicts in criss-cross merges where the merge bases disagree.
- `dulwich log <path>` now applies git's default history simplification.
- Honour the `eol` gitattribute.
- Fix `add` and `commit` in SHA-256 repositories.

## 1.2.15 (2026-09-14)

- Add `dulwich commit --author`, `-C/--reuse-message` and `-c/--reedit-message`.
- Bare `dulwich branch` and `dulwich branch --list` now list branches.
- Set up branch tracking information for the branch checked out by a clone.
- Several fixes to `.gitignore` precedence and pattern handling.
- Detect delta cycles in crafted packs, and fix several quadratic code paths.

## 1.2.14 (2026-08-28)

Avoid catastrophic regex backtracking on wildmatch patterns with consecutive `**` segments.

## 1.2.13 (2026-08-24)

- Make concurrent pack reads thread-safe.
- Add `dulwich hook run` for running hooks manually.
- Bound fetch negotiation like C Git does, which speeds up fetches over HTTP.
- New public `dulwich.wildmatch` module, matching git's bracket expression semantics.
- Fix cloning from SSH servers that don't hand the command to a shell, such as Bitbucket Server.
- Several security fixes, including widening `core.sharedRepository` modes the way git does and refusing patches that target `.git`.

## 1.2.12 (2026-07-19)

- Security fix: refuse to check out entries whose leading path resolves through a symlink.
- Fix `Bundle.store_objects()` silently dropping delta objects.

## 1.2.11 (2026-07-16)

- Honour `core.worktree`.
- Porcelain functions now read `GIT_SSH_COMMAND`, `GIT_SSH` and `GIT_PROTOCOL` themselves, so they work again when dulwich is used as a library, and take an `env` argument.
- Add a `remote` argument to `porcelain.archive()`.
- Recurse into subtrees when merging trees.
- Several hardening fixes, including for `core.protectHFS` on macOS.

## 1.2.10 (2026-07-07)

Fix a regression in 1.2.9 where larger loose objects failed to parse.

## 1.2.9 (2026-07-06)

Security release, mostly hardening against denial of service: bound zlib decompression of objects, reject self-referencing `OFS_DELTA` entries, bound chunked request bodies in `dulwich.web`, and reject drive-letter checkout paths on Windows.

## 1.2.8 (2026-07-05)

- Fix pushes of large repositories over HTTP timing out on servers like GitHub, and support `http.postBuffer`.
- A large number of security fixes, including GHSA-8w8g-wq8h-fq33 and GHSA-5fqc-mrg8-w798 (writes outside the work tree via symlinks), shell quoting in the SSH client, object id validation, GPG signature verification and several ReDoS and quadratic parsing issues.
- Support pyo3 0.29.

## 1.2.7 (2026-06-12)

- Add `request-pull` and `range-diff` commands.
- Verify that objects retrieved by id actually hash to that id.
- Check out files whose names contain a colon or backslash.
- Several fixes for `gc` and `repack` on Windows.
- Discover packs named `loose-<hash>.pack`, as written by `git maintenance`.

## 1.2.6 (2026-05-31)

Security release: honour `core.protectNTFS`/`core.protectHFS` on all work tree updates, and reject patch target paths that escape the work tree.

## 1.2.5 (2026-05-28)

Security release:

- GHSA-gfhv-vqv2-4544: validate submodule paths.
- CVE-2026-42305: harden tree path validation against names that are dangerous on Windows. `core.protectNTFS` now defaults to true on every platform.
- CVE-2026-42563: shell-quote values substituted into merge driver commands.
- CVE-2026-47712: sanitize commit subjects used in `format_patch` file names.
- Honour `receive.maxInputSize`.

## 1.2.4 (2026-05-21)

Tolerate ref names with empty path components again (with a `DeprecationWarning`), since older Poetry releases construct them.

## 1.2.3 (2026-05-20)

Honour `GIT_CONFIG_COUNT`/`GIT_CONFIG_KEY_<n>`/`GIT_CONFIG_VALUE_<n>`, stricter ref name checking and various fixes for SHA-256 repositories and malformed packs.

## 1.2.2 (2026-05-19)

Bugfix release, including a fix for lookups in repositories with a `multi-pack-index` and for escaping of config subsection names.

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
