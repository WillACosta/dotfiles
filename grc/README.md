# Generic Colorizer (GRC)

It's a syntax highlighter for system logs and certain commands outputs. It's provide two tools for interaction:

- `grcat`: It takes an output, colorize it and write to the _stdoutput_ again.
- `grc`: It acts as a frontend, it receives a command and pipe its stdoutput into `grcat`.

## Getting Started

1. Installing

```shell
sudo apt-get install grc
# or
brew install grc
```

2. Executing

```shell
grc <command>
```

## References

[Generic Colorizer Official Repository](https://github.com/garabik/grc)
