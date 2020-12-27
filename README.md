# linux-pkg

Linux kernel build for Archlinux with a patch set by TK-Glitch, Piotr Górski, Hamad Al Marri and, Con Kolivas and Alfred Chen. 

# Version

- stable : 5.10.3
- mainline : 5.10-rc7

# Build 

    git clone https://github.com/kevall474/linux-pkg
    cd linux-pkg
    env _release=(1 or 2) _cpu_sched=(1,2,3,4,,5 or 6) _compiler=(1,2,3 or 4) makepkg -s
