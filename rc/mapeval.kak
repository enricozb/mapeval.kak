# mapeval evaluates each selection as a python expression with `_` set to the selection's index.
# if an expression causes an exception, it is left unchanged.
define-command mapeval %{
  execute-keys -draft %sh{
    eval set -- "$kak_quoted_selections"
    while [ $# -gt 0 ]; do
      printf '%s\n' "$1"
      shift
    done | python -c "def f():
      import sys

      # ensure the main selection is at index 1
      print(f'{$kak_main_reg_hash - 1}(', end='')

      for _, sel in enumerate(sys.stdin, start=1):
        sel = sel.strip('\n')
        try:
          sel = eval(sel.strip())
        except:
          pass

        print(f'Z c{sel}<esc><a-z>a)', end='')
f()"
  }
}

map global normal + ': mapeval<ret>'
