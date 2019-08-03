#! python
#  -*- coding: utf-8 -*-

'''  This is an sample python module for vim 
'''

older_import = None
def import_module(name, file):
    import importlib.util
    spec = importlib.util.spec_from_file_location(name, file)
    module = importlib.util.module_from_spec(spec)
    try:
        spec.loader.exec_module(module)
    except:
        pass
    return module

if older_import is None:
    older_import = __import__
    __import__ = import_module
    print('older_import is None')
else:
    print('vim_test imported!')
    print('__import__ = {}'.format(__import__))
    print('import_module = {}'.format(import_module))
    print('older_import = {}'.format(older_import))
    print('importlib.import_module = {}'.format(importlib.import_module))

