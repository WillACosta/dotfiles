## DDC/CI

It's a protocol available in some monitors that enable other hardwares to control its configurations, including power, video input, brightness, and so on.

There are some payed and _Open-Source_ options out there, but we can use a very simple way to control video input, which is the case for my needs:

## MacOS (Apple Silicon Only)

```shell
sd() {
  local display=$1
  local input=$2
  case $input in
    dp) val=15 ;;
    hdmi1) val=17 ;;
    hdmi2) val=18 ;;
    usbc) val=27 ;;
    *) echo "Unknown input: $input"; return 1 ;;
  esac
  m1ddc display "$display" set input "$val"
}
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
