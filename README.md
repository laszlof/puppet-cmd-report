This module will allow you to pass your puppet reports to an arbitrary script.

## Usage

Create a file in your puppet config directory called: `cmdreport.yaml` with the following format:

```yaml
cmd: "/path/to/somecmd --somearg %s --someotherarg"
replace_char: "%s"
```

The script will replace the `replace_char` with the path to a temp file containing the report generated from puppet.
