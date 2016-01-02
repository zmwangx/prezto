#!/usr/bin/env python3

"""setuptools stubs.

Here we only stubbed the symbols in setuptools.__all__. Hopefully that's
enough (actually I can't remember seeing any setup.py using more than
setup and find_packages).

setup has been spoofed to print the names of scripts, console_scripts
and gui_scripts defined in the arguments to setup. Some user-friendly
messages are also printed to stderr.

"""

from __future__ import print_function

import re
import sys
import os

__all__ = [
    'setup', 'Distribution', 'Feature', 'Command', 'Extension', 'Require',
    'find_packages'
]

def setup(**kwargs):
    scripts = [os.path.basename(script_path)
               for script_path in kwargs.pop('scripts', [])]
    if scripts:
        print('scripts:\n  - %s' % '\n  - '.join(scripts), file=sys.stderr)
    entry_points = kwargs.pop('entry_points', {})
    for entry_point in ['console_scripts', 'gui_scripts']:
        extra_scripts = [re.split('(\s|=)', spec.strip())[0]
                         for spec in entry_points.pop(entry_point, [])]
        if extra_scripts:
            print('%s:\n  - %s' % (entry_point, '\n  - '.join(extra_scripts)),
                  file=sys.stderr)
        scripts.extend(extra_scripts)
    print('\n'.join(sorted(scripts)))

class Distribution(object): pass
class Feature(object): pass
class Command(object): pass
class Extension(object): pass
class Require(object): pass
def find_packages(**kwargs): pass
