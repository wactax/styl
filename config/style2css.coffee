#!/usr/bin/env coffee

> ./postcss
  path > join dirname

import {readFile} from 'fs/promises'
import stylus from 'stylus'
import uridir from '@w5/uridir'

ROOT = dirname uridir import.meta

export default (path)=>
  css = await readFile(path,'utf8')
  css = await stylus(css).set(
    'filename'
    path
  ).define(
    'inline-url'
    stylus.url({ paths: [join(ROOT,'svg')] })
  ).render()
  await postcss.process(css).css
