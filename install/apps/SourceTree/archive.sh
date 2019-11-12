#!/usr/bin/env bash

cp "$HOME/Library/Application Support/SourceTree/actions.plist" actions.plist

# `Plist` Has Two Formats: `binary` & `xml`
# `binary` is more compact & is used by SourceTree by default.
# However, we convert it to `xml` here to store in Git.
plutil -convert xml1 actions.plist
