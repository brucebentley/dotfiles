#!/usr/bin/env python3

import subprocess
from glob import glob

from os.path import basename, splitext, join

import xrdb2Xresources
import xrdb2putty
import xrdb2kitty
import xrdb2windowsterminal
import xrdb2dynamic_color

if __name__ == '__main__':

    for f in glob("../schemes/*.itermcolors"):
        base_name = splitext(basename(f))[0]
        xrdb_filepath = join('../xrdb', base_name + '.xrdb')
        with open(xrdb_filepath, 'w') as fout:
            ret_code = subprocess.Popen(
                ['./iterm2xrdb', f], stdout=fout).wait()
            print(ret_code and "ERROR" or "OK" + " --> " + xrdb_filepath)

    print()
    xrdb2Xresources.main('../xrdb/', '../Xresources/')
    print('OK --> ' + '../Xresources/')
    xrdb2putty.main('../xrdb/', '../putty/')
    print('OK --> ' + '../putty/')
    xrdb2kitty.main('../xrdb/', '../kitty/')
    print('OK --> ' + '../kitty/')
    xrdb2windowsterminal.main('../xrdb/', '../windowsterminal/')
    print('OK --> ' + '../windowsterminal/')
    xrdb2dynamic_color.main('../xrdb/', '../dynamic-colors/')
    print('OK --> ' + '../dynamic-colors/')
