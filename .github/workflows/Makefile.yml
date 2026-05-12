name: Compilar dylib DOMIDIOS
on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  build:
    runs-on: macos-latest
    steps:
      - name: Checkout del código
        uses: actions/checkout@v4

      - name: Instalar Theos
        run: |
          bash -c "$(curl -fsSL https://raw.githubusercontent.com/theos/theos/master/bin/install-theos)"
          echo "THEOS=~/theos" >> $GITHUB_ENV

      - name: Compilar dylib
        run: |
          export THEOS=~/theos
          make package FINALPACKAGE=1

      - name: Guardar dylib (Artifacts)
        uses: actions/upload-artifact@v4
        with:
          name: DominioFlex-Dylib
          path: .theos/obj/main/debug/*.dylib
