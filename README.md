# zpreview.yazi

Preview archive contents in Yazi's preview pane using `7zz`. Encrypted
archives show a "filenames encrypted" notice, and multi-volume parts after the
first show their part number.

## Requirements

- Yazi 26.9.1 or newer
- `7zz` (7-Zip)
- [zeppelin.yazi](https://github.com/ibtrujillo/zeppelin.yazi)

## Installation

```sh
ya pkg add ibtrujillo/zpreview
ya pkg add ibtrujillo/zeppelin
```

## Usage

```toml
# yazi.toml
[plugin]
prepend_previewers = [
  { url = "*.7z", run = "zpreview" },
  { url = "*.rar", run = "zpreview" },
  { url = "*.7z.[0-9][0-9][0-9]", run = "zpreview" },
  { url = "*.zip.[0-9][0-9][0-9]", run = "zpreview" },
  { url = "*.r[0-9][0-9]", run = "zpreview" },
]
```
