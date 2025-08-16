#!/usr/bin/env python3
"""Validate planets/data/planets.lua entries.

Ensures every planet entry defines `img`, `imgPS`, `quadWidth`, and
`quadHeight`.  Verifies the quad dimensions do not exceed the
corresponding image dimensions.
"""
import os
import re
import sys
from PIL import Image

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
PLANETS_FILE = os.path.join(ROOT, 'planets', 'data', 'planets.lua')

ENTRY_START = 'planets[XY] = {'


def parse_planets():
    """Parse planet definitions from the Lua data file."""
    entries = []
    current = None
    with open(PLANETS_FILE, 'r', encoding='utf-8') as handle:
        for line in handle:
            stripped = line.strip()
            if stripped.startswith(ENTRY_START):
                current = {}
            elif current is not None:
                if stripped == '}':
                    entries.append(current)
                    current = None
                    continue
                m = re.search(r'img=(?:assets\.image|love\.graphics\.newImage)\("([^"]+)"\)', stripped)
                if m:
                    current['img'] = m.group(1)
                m = re.search(r'imgPS=(?:assets\.image|love\.graphics\.newImage)\("([^"]+)"\)', stripped)
                if m:
                    current['imgPS'] = m.group(1)
                m = re.search(r'quadWidth=(\d+)', stripped)
                if m:
                    current['quadWidth'] = int(m.group(1))
                m = re.search(r'quadHeight=(\d+)', stripped)
                if m:
                    current['quadHeight'] = int(m.group(1))
    return entries


def validate(entries):
    """Validate parsed entries and return True if all checks pass."""
    ok = True
    for idx, entry in enumerate(entries):
        missing = [k for k in ('img', 'imgPS', 'quadWidth', 'quadHeight') if k not in entry]
        if missing:
            print(f"Entry {idx} missing fields: {', '.join(missing)}")
            ok = False
            continue
        # Resolve image paths relative to repository root
        img_path = os.path.join(ROOT, entry['img'])
        if not os.path.exists(img_path):
            print(f"Image not found: {img_path}")
            ok = False
        else:
            with Image.open(img_path) as im:
                width, height = im.size
            if entry['quadWidth'] > width or entry['quadHeight'] > height:
                print(
                    f"Quad {entry['quadWidth']}x{entry['quadHeight']} exceeds image {width}x{height} for {entry['img']}"
                )
                ok = False
        imgps_path = os.path.join(ROOT, entry['imgPS'])
        if not os.path.exists(imgps_path):
            print(f"Planet screen image not found: {imgps_path}")
            ok = False
    return ok


def main():
    entries = parse_planets()
    if not entries:
        print('No planet entries found.')
        return 1
    if validate(entries):
        print('Planets data validation passed.')
        return 0
    return 1


if __name__ == '__main__':
    sys.exit(main())
