#!/usr/bin/env coffee

> iter2file
  fs > existsSync
  ./env > SRC ROOT CSS
  path > join
  fs/promises > readFile
  @w5/walk > walkRel

< default main = =>
  need = new Set()

  for dir from [SRC,CSS]
    for await p from walkRel dir
      if p[..2]!='var' or ~ './\\'.indexOf p[4]
        fp = join(dir, p)
        (
          await readFile(fp,'utf8')
        ).replaceAll(
          /[\s,](svg-[^\s]+)/g
          (input,svg)=>
            name = svg[4..]
            sp = join ROOT,'svg',name+'.svg'
            if existsSync(sp)
              need.add(name)
            else
              console.log "❌ #{sp} not exist ( #{svg} used in #{fp} )"
            input
        )

  await iter2file(
    join ROOT,'svg.styl'
    ->
      yield 'var_svg()\n'
      for i from need
        yield "  --svg-#{i} \"#{i}.svg\"\n"
      return
  )

  await iter2file(
    join SRC,'var/svg.styl'
    ->
      for i from need
        yield "svg-#{i} = var(--svg-#{i})\n"
      return
  )

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

