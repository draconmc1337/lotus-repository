#!/bin/sh
# migrate-repo-layout.sh
# Chuyển toàn bộ repo từ flat layout sang directory layout:
#   <repo>/<letter>/pkgbuild_<name>  →  <repo>/<letter>/<name>/PKGBUILD
#
# Usage:
#   ./migrate-repo-layout.sh [--dry-run] [repo_root]
#   repo_root mặc định là thư mục hiện tại
#
# An toàn: chỉ rename/move, không xóa gì cả.
# Chạy --dry-run trước để xem những gì sẽ xảy ra.

set -e

DRY=0
REPO_ROOT="."

for arg in "$@"; do
    case "$arg" in
        --dry-run|-n) DRY=1 ;;
        *) REPO_ROOT="$arg" ;;
    esac
done

if [ $DRY -eq 1 ]; then
    echo "=== DRY RUN — không thay đổi gì ==="
fi

moved=0
skipped=0
already=0

# ── scan tất cả pkgbuild_ files ──────────────────────────────────────────
while IFS= read -r pbfile; do
    [ -f "$pbfile" ] || continue

    # lấy tên từ filename: pkgbuild_foo → foo
    fname=$(basename "$pbfile")
    pkgname="${fname#pkgbuild_}"
    [ -z "$pkgname" ] && continue

    dir=$(dirname "$pbfile")
    target_dir="$dir/$pkgname"
    target_file="$target_dir/PKGBUILD"

    # nếu đã có name/PKGBUILD rồi thì skip
    if [ -f "$target_file" ]; then
        echo "  [skip] already migrated: $target_file"
        skipped=$((skipped + 1))
        continue
    fi

    # nếu thư mục name/ đã tồn tại nhưng không có PKGBUILD
    # thì vẫn move vào
    echo "  [move] $pbfile"
    echo "      →  $target_file"

    if [ $DRY -eq 0 ]; then
        mkdir -p "$target_dir"
        mv "$pbfile" "$target_file"
    fi
    moved=$((moved + 1))

done << FINDEOF
$(find "$REPO_ROOT" -type f -name 'pkgbuild_*' | sort)
FINDEOF

echo ""
echo "── kết quả ─────────────────────────────────────"
echo "  migrated : $moved"
echo "  skipped  : $skipped  (already directory layout)"
if [ $DRY -eq 1 ]; then
    echo ""
    echo "  → chạy lại không có --dry-run để migrate thực sự"
fi
