## DDC/CI

It's a protocol available in some monitors that enable other hardwares to control its configurations, including power, video input, brightness, and so on.

There are some payed and _Open-Source_ options out there, but we can use a very simple way to control video input, which is the case for my needs:

## MacOS (Apple Silicon Only)

```shell
#!/bin/bash

# Define your Monitor Indicies (Adjust based on 'm1ddc display list')
MON_ALIENWARE=1
MON_UPERFECT=2

# Function to get DDC value
get_val() {
  case $1 in
    dp) echo 15 ;;
    hdmi1) echo 17 ;;
    hdmi2) echo 18 ;;
    usbc) echo 27 ;;
    *) echo "Unknown"; exit 1 ;;
  esac
}

# Logic for switching
case $1 in
  1|2) # Switch a single monitor: sd <index> <input>
    val=$(get_val "$2")
    m1ddc display "$1" set input "$val"
    ;;

  both) # Switch both: sd both <input_mon1> <input_mon2>
    val1=$(get_val "$2")
    val2=$(get_val "$3")
    m1ddc display $MON_ALIENWARE set input "$val1"
    m1ddc display $MON_UPERFECT set input "$val2"
    ;;

  *)
    echo "Usage: sd [1|2|both] [input]"
    exit 1
    ;;
esac
```

## Windows

> Edit your $PROFILE file: run `notepad $PROFILE` in powershell and then:

```shell
function sd($displayNum, $inputName) {
    $inputs = @{
        "dp"    = 15
        "hdmi1" = 17
        "hdmi2" = 18
        "usbc"  = 27
    }
    $val = $inputs[$inputName]
    $mon = if ($displayNum -eq 1) { "Primary" } else { "Secondary" }

    # Path to your exe (adjust if necessary)
    & "C:\Path\To\ControlMyMonitor.exe" /SetValue $mon 60 $val
}
```
