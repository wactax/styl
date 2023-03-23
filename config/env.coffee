#!/usr/bin/env coffee

> @w5/uridir
  path > join dirname

export ROOT = dirname uridir(import.meta)
export CSS = join ROOT, 'css'
export SRC = join ROOT, 'src'

