from __future__ import absolute_import

import shlex
import subprocess
import sys

import serving

if sys.argv[1] == 'serve':
    serving.main()
else:
    subprocess.check_call(shlex.split(' '.join(sys.argv[1:])))

# prevent docker exit
subprocess.call(['tail', '-f', '/dev/null'])
