# Downloads

## PyPI (recommended)

```
pip install dulwich
```

If you want a pure-Python build without the optional Rust extensions:

```
pip install dulwich --config-settings="--build-option=--pure"
```

## Releases

Source tarballs and signatures for all releases are available on the
[GitHub releases page](https://github.com/dulwich/dulwich/releases).

## From source

```
git clone https://github.com/dulwich/dulwich
cd dulwich
pip install .
```

## Debian / Ubuntu

Dulwich is packaged in Debian and Ubuntu as `python3-dulwich`:

```
apt install python3-dulwich
```

For a more recent snapshot, builds from Debian `sid` are available via the
[Debian Janitor](https://janitor.debian.net/fresh) fresh-snapshots archive.
