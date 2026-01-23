#!/usr/bin/env python

import css_inline
import sys


html = sys.stdin.read()

inlined = css_inline.inline(html)

print(inlined)


