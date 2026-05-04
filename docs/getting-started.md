# Getting Started

Dulwich provides both a lower-level API and a higher-level "porcelain" interface.

## Installation

```
pip install dulwich
```

If you want a pure-Python build without the optional Rust extensions:

```
pip install dulwich --config-settings="--build-option=--pure"
```

## Porcelain (high-level API)

The `dulwich.porcelain` module mirrors common Git commands:

```python
from dulwich import porcelain

# Clone a repository
porcelain.clone("https://github.com/dulwich/dulwich", "dulwich")

# Show recent log entries
porcelain.log(".", max_entries=5)

# Stage and commit
porcelain.add(".", paths=["README.md"])
porcelain.commit(".", message=b"Update README\n", author=b"Alice <alice@example.com>")
```

## Low-level API

For direct access to Git objects and refs:

```python
from dulwich.repo import Repo

r = Repo(".")
head_sha = r.head()
commit = r[head_sha]
print(commit.message)
print(commit.author)

# Walk history
for entry in r.get_walker():
    print(entry.commit.id, entry.commit.message[:50])
```

## Further documentation

- Full tutorial and API docs: <https://dulwich.readthedocs.io/>
- API reference: <https://www.dulwich.io/api/>
- Examples: <https://github.com/dulwich/dulwich/tree/master/examples>
