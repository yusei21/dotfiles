#!/usr/bin/env python3
"""Generate a subtle 16:9 charcoal gradient PNG using only Python stdlib."""
import pathlib
import struct
import sys
import zlib

def chunk(kind, payload):
    return struct.pack("!I", len(payload)) + kind + payload + struct.pack("!I", zlib.crc32(kind + payload) & 0xffffffff)

def main():
    target = pathlib.Path(sys.argv[1]).expanduser() if len(sys.argv) > 1 else pathlib.Path.home() / ".config/hypr/minimal-glass.png"
    width, height = 960, 540
    pixels = bytearray()
    for y in range(height):
        pixels.append(0)
        for x in range(width):
            dx = (x / width - 0.65)
            dy = (y / height - 0.32)
            glow = max(0.0, 1.0 - (dx * dx / 0.45 + dy * dy / 0.55))
            shade = int(5 * glow + 3 * (y / height))
            pixels.extend((13 + shade, 15 + shade, 18 + shade))
    header = b"\x89PNG\r\n\x1a\n"
    data = header + chunk(b"IHDR", struct.pack("!2I5B", width, height, 8, 2, 0, 0, 0))
    data += chunk(b"IDAT", zlib.compress(pixels, 9)) + chunk(b"IEND", b"")
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)
    print("Wallpaper:", target)

if __name__ == "__main__":
    main()
