# mapeval evaluates each selection as a python expression with `_` set to the selection's index.
# if an expression causes an exception, it is left unchanged.
define-command mapeval %{
  execute-keys -draft %sh{
    eval set -- "$kak_quoted_selections";

    # the if True there is so the code is within a block and can be indented arbitrarily
    python -c "if True:
      import sys

      # ensure the main selection is at index 1
      print(f'{$kak_main_reg_hash - 1}(', end='')

      for _, sel in enumerate(sys.argv[1:], start=1):
        sel = sel.strip('\n')
        try:
          sel = eval(sel.strip())
        except:
          pass

        print(f'Z,c{sel}<esc><a-z>a)', end='')" \
    "$@"
  }
}
