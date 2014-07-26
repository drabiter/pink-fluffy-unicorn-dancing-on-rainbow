#!/usr/bin/env node

sleep = require('sleep')

rate  = 100000

openUnicorn = [
  "          /| ",
  " ~～～～~/ | ",
  "|       O  O ",
  "|         ∇ |",
  " ~~~~∪∪~~~∪∪ "
]
closeUnicorn = [
  "          /| ",
  " ～～～～/ | ",
  "|       ⌒  ⌒ ",
  "|         ∇ |",
  " ~~∪∪~~~∪∪~~ "
]
unicornWidth  = openUnicorn[0].length
termWidth     = process.stdout.columns
unicornOffset = (termWidth - unicornWidth) / 2
colors        = [160, 9, 148, 82, 33, 90]

clear = ->
  println(`'\033c'`)

print = (_) ->
  process.stdout.write(_ || '')

println = (_) ->
  console.log(_ || '')

renderSpace = (number) ->
  for i in [0...number]
    print(" ");

pinkify = (_) ->
  "\x1b[38;5;14m" + _ + "\x1b[0m"

renderUnicorn = (unicorn) ->
  for line in unicorn
    renderSpace(unicornOffset)

    println(pinkify(line))

rainbowify = (str, index) ->
  color = colors[index]
  "\x1b[38;5;" + color + "m" + str + "\x1b[0m"

renderRainbow = (rainbow) ->
  for i in [0...5]
    for j in [0...termWidth]
      _ = counter + j
      if (_ % 2 is 0)
        print(rainbowify('-', i))
      else
        print(rainbowify('_', i))
    println()

draw = (counter) ->
  _unicorn = if (counter % 10 > 5) then openUnicorn else closeUnicorn
  renderUnicorn(_unicorn)

  renderRainbow(counter)


counter = 0

while(true)
  clear()

  draw(counter)
  counter++

  println('Press Ctrl-C to exit...')

  sleep.usleep(rate)

