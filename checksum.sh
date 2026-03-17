for pb in /mnt/lfs/usr/src/lpm/pkgbuild_*; do
    pkgname=$(basename $pb | sed 's/pkgbuild_//')
    
    # source pkgbuild để expand variables
    eval $(bash -c "source '$pb' 2>/dev/null; echo pkgver=\$pkgver")
    
    expected_md5=$(bash -c "source '$pb' 2>/dev/null; echo \$md5sums" | cut -d'"' -f1)
    expected_sha=$(bash -c "source '$pb' 2>/dev/null; echo \$sha256sums" | cut -d'"' -f1)
    
    srcfile=$(bash -c "source '$pb' 2>/dev/null; echo \$source" | grep -o '[^/]*\.tar\.[^[:space:]]*')
    
    [ -z "$srcfile" ] && continue
    [ -f "/mnt/lfs/sources/$srcfile" ] || { echo "MISSING: $pkgname ($srcfile)"; continue; }
    
    if [ -n "$expected_md5" ]; then
        actual=$(md5sum "/mnt/lfs/sources/$srcfile" | cut -d' ' -f1)
        [ "$actual" = "$expected_md5" ] \
            && echo "OK  [md5] $pkgname" \
            || echo "BAD [md5] $pkgname  expected=$expected_md5  actual=$actual"
    fi
    
    if [ -n "$expected_sha" ]; then
        actual=$(sha256sum "/mnt/lfs/sources/$srcfile" | cut -d' ' -f1)
        [ "$actual" = "$expected_sha" ] \
            && echo "OK  [sha] $pkgname" \
            || echo "BAD [sha] $pkgname  expected=$expected_sha  actual=$actual"
    fi
done
