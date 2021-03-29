#!/usr/bin/bash

# gcc build

makepkg -s

rm -rf pkg/ src/

env _cpu_shed=1 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=2 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=3 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=4 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=5 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=6 makepkg -s

rm -rf pkg/ src/

# clang build

env _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=1 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=2 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=3 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=4 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=5 _compiler=2 makepkg -s

rm -rf pkg/ src/

env _cpu_shed=6 _compiler=2 makepkg -s

rm -rf pkg/ src/
