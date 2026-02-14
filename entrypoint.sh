#!/bin/sh
# Railway single-volume workaround.
# Volume mounted at /booklore-data. App expects /app/data, /books, /bookdrop.
# Symlinks break Java's Files.createDirectory() — so we remove them at runtime
# and replace with real dirs backed by the volume.

set -e

mkdir -p /booklore-data/app-data /booklore-data/books

# Remove any build-time symlinks or dirs
rm -rf /app/data /books /bookdrop

# Create real mount-point dirs
mkdir -p /app/data /books /bookdrop

# Bind mount volume subdirs over the real dirs
mount --bind /booklore-data/app-data /app/data 2>/dev/null || {
  # If bind mount fails (no privilege), fall back to symlinks
  rm -rf /app/data /books
  ln -sf /booklore-data/app-data /app/data
  ln -sf /booklore-data/books /books
}
mount --bind /booklore-data/books /books 2>/dev/null || true

# Hand off to original entrypoint
exec /__cacert_entrypoint.sh /start.sh
