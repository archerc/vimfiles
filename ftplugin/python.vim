setlocal foldmethod=indent
setlocal tabstop=4 shiftwidth=4 expandtab
setlocal softtabstop=4
setlocal textwidth=79
setlocal autoindent
setlocal fileformat=unix
setlocal fileencoding=utf-8

if has('python3')
  :py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
endif
