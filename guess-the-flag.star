## Built by Douwe Maan, based on https://github.com/tidbyt/community/blob/main/apps/flags/flags.star:
# Copyright 2022 Brandon Jones
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

load("encoding/base64.star", "base64")
load("random.star", "random")
load("render.star", "render")
load("animation.star", "animation")
load("pixlib/const.star", "const")
load("pixlib/file.star", "file")
load("pixlib/font.star", "font")

def main(config):
  countries = file.read('countries.json')
  country = countries.values()[random.number(1, len(countries) - 1)]

  flag = base64.decode(country["flag"])
  name = country["name"]

  text_font = "tom-thumb"
  text_height = font.height(text_font)

  title_widget = render.Text("Guess the flag!", font=text_font)

  name_widget = render.Text(name, font=text_font)
  name_widget = name_widget if len(name) <= 16 else render.Marquee(width=64, child=name_widget)

  flag_height = const.HEIGHT - text_height - 2
  flag_widget = render.Image(src=flag, height=flag_height)

  return render.Root(
    child = animation.Transformation(
      child = render.Column(
        cross_align = "center",
        children = [
          render.Padding(pad=(0,0,0,1), child=title_widget),
          render.Box(width=const.WIDTH, height=flag_height, child=flag_widget),
          render.Padding(pad=(0,1,0,0), child=name_widget)
        ],
      ),
      duration=const.FPS // 2, # Half a second
      delay=const.FPS * 7, # 7 seconds
      keyframes=[
        animation.Keyframe(
          percentage=1.0,
          transforms=[animation.Translate(0, -text_height)],
          curve="ease_in_out",
        ),
      ],
    ),
  )
