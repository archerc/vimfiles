#! python
#  -*- coding: utf-8 -*-

'''  This is an sample python module for vim
'''

import vim
import os
import subprocess


def find_matlab_root():
    matlab_root = os.environ.get('MATLABROOT',
            vim.vars.get('matlab_root',
                'c:\Applications\MATLAB\R2018b'
                )
            )
    matlab_bin = os.path.join(matlab_root, 'bin\matlab.exe')
    if os.path.exists(matlab_bin):
        return matlab_root
    else:
        print('FileNotFound: {} can not be found.'.format(matlab_bin))


def install_matlab_engine():
    matlab_root = find_matlab_root()
    matlab_engine_setup = os.path.join(matlab_root, 'extern\engines\python\setup.py')
    if os.path.exists(matlab_engine_setup):
        return matlab_engine_setup

if __name__ == '__main__':
    # print('loading vim_test for testing python in vim')
    print(install_matlab_engine())
    help(subprocess)
