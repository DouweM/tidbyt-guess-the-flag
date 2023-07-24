# Tidbyt + Guess the flag!

[Tidbyt](https://tidbyt.com/) app that lets you guess what country a flag belongs to. The correct answer is shown after 7 seconds.

![Screenshot](screenshot.webp)

---

Note that this app **cannot be installed from Tidbyt's smartphone app** as it uses features that (for security reasons) are not supported in [community apps](https://tidbyt.dev/docs/publish/community-apps) that run on Tidbyt's official app server.
(Your Tidbyt does not run apps directly; it depends on a server to periodically run apps and push the resulting images to the device.)

Specifically, this app uses [Pixlib](https://github.com/DouweM/tap-pixlet/tree/main/tap_pixlet/pixlib), the unofficial standard library for [Pixlet](https://github.com/tidbyt/pixlet) (the Tidbyt app development framework), similar to how [Starlib](https://github.com/qri-io/starlib) is the unofficial standard library for [Starlark](https://github.com/google/starlark-go) (the Python-like language Tidbyt apps are written in).

These features are enabled by [`tap-pixlet`](https://github.com/DouweM/tap-pixlet), an unofficial Tidbyt app runner that extends Pixlet with the Pixlib standard library and advanced abilities like reading local (image) files, reaching local network resources, and running Python scripts and packages.

To render this app to your Tidbyt or a WebP image file, follow the instructions below.
They use `tap-pixlet` to run the app, [`target-tidbyt`](https://github.com/DouweM/target-tidbyt) and [`target-webp`](https://github.com/DouweM/target-tidbyt) to push the resulting image to your Tidbyt or a WebP image file, and [Meltano](https://github.com/meltano/meltano) to tie these components together.
You can use these same components to set up your own Tidbyt app server for apps like this one, that are too advanced for the official community app server.

## Installation

1. Install [Pixlet](https://github.com/tidbyt/pixlet):

    - On macOS:

      ```bash
      brew install tidbyt/tidbyt/pixlet
      ```

    - [Other operating systems](https://tidbyt.dev/docs/build/installing-pixlet)

1. Install [Meltano](https://github.com/meltano/meltano):

   - With `pip`:

      ```bash
      pip install meltano
      ```

   - [Other installation methods](https://docs.meltano.com/getting-started/installation)

1. Clone this repository and enter the new directory:

    ```bash
    git clone https://github.com/DouweM/tidbyt-guess-the-flag.git
    cd tidbyt-guess-the-flag
    ```

1. Install [`tap-pixlet`](https://github.com/DouweM/tap-pixlet), [`target-tidbyt`](https://github.com/DouweM/target-tidbyt), and [`target-webp`](https://github.com/DouweM/target-tidbyt) using Meltano:

    ```bash
    meltano install
    ```

## Usage

### Render app to a WebP image file

The image will be created at `output/guess-the-flag/<timestamp>.webp`.
The exact path is also printed in the command output.

#### Regular size (64x32)

```bash
meltano run webp
```

#### Magnified 8 times (512x256)

```bash
TAP_PIXLET_MAGNIFICATION=8 meltano run webp
```

### Render app to your Tidbyt

#### Configure your Tidbyt

1. Create your own `.env` configuration file from the sample:

   ```bash
   cp .env.sample .env
   ```

1. Find your Device ID and your API Token in the Tidbyt smartphone app under Settings > General > Get API Key.

1. Update `.env` with your configuration:

   ```bash
   TIDBYT_DEVICE_ID="<device ID>"
   TIDBYT_TOKEN="<token>"
   ```

#### Send to foreground

The app will immediately show up on your Tidbyt.
This is useful during development.

```bash
TAP_PIXLET_BACKGROUND=false meltano run tidbyt
```

#### Send to background

The app will be added to the Tidbyt app rotation.
This is useful when you're running this command on a schedule, to make sure that the app will be up to date the next time it comes up in the app rotation.

```bash
meltano run tidbyt
```

## Acknowledgements

This app is based on the ["flags" community app](https://github.com/tidbyt/community/blob/main/apps/flags/flags.star) by [@btjones](https://github.com/btjones):

```
Copyright 2022 Brandon Jones

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
