# mapeval.kak

Creates a `mapeval` command that evaluates each selection as a python expression with `_` set to the selection's index. If an expression causes an exception, it is left unchanged.

## Usage
If your buffer looks like this:
```
_
_ + 1
_ * "0"
_ * _
_ == 5
```
and you highlight each line as it's own cursor by doing something like `%<a-s>H`, and then run `mapeval` the cursors will be replaced with the following:
```
1
3
000
16
True
```
