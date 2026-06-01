#!/bin/bash

ROOT="/home/diinki_/Projects/lotus-repository"

for repo in base extra lotus; do
  P_DIR="$ROOT/$repo/p"
  REPO_DIR="$ROOT/$repo"

  [ -d "$P_DIR" ] || {
    echo "⚠ Không có $repo/p, bỏ qua."
    continue
  }

  echo "📦 Đang xử lý: $repo"

  # Di chuyển từ repo/p/x/pkgbuild_* → repo/x/pkgbuild_*
  for letter_dir in "$P_DIR"/*/; do
    [ -d "$letter_dir" ] || continue
    letter="$(basename "$letter_dir")"

    mkdir -p "$REPO_DIR/$letter"

    for item in "$letter_dir"pkgbuild_*; do
      [ -e "$item" ] || continue
      name="$(basename "$item")"
      mv "$item" "$REPO_DIR/$letter/$name"
      echo "  ✓  $repo/p/$letter/$name  →  $repo/$letter/$name"
    done

    rmdir "$letter_dir" 2>/dev/null
  done

  # Xóa folder p/ nếu rỗng
  rmdir "$P_DIR" 2>/dev/null && echo "  🗑  Xóa $repo/p/"
done

echo "✅ Xong!"
