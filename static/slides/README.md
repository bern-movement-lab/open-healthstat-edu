## Prerequisites

- https://en.wikipedia.org/wiki/Make_(software) - to seamlessly render HTMLs and PDFs (see below)
- https://quarto.org/ - turn QMD into HTML presentations
- A [TeX](https://en.wikipedia.org/wiki/TeX) distribution to produce PDFs. Quarto recommends [TinyTeX](https://yihui.org/tinytex/). For installation instructions refer to the [Quarto Guide > PDF Basics](https://quarto.org/docs/output-formats/pdf-basics.html#prerequisites).
- https://github.com/astefanutti/decktape - to turn the html rendered through Quarto into nice looking PDFs

## Rendering slides

``` shell
# Build all output
make    # same as: make all

# Build the light PDFs (faster if you need only them)
make light

# Build just the dark PDFs
make dark

# Remove all output
make clean
```

## To preview slides for authoring

``` shell
quarto preview BSc-Intro-Jamovi.qmd --to revealjs-dark --output BSc-Intro-Jamovi-dark.html
```

Replace `BSc-Intro-Jmaovi.qmd` and `BSc-Intro-Jmaovi-dark.html` with the respective input and output file names.
