# linux-pkg

Linux kernel build for Archlinux with a patch set by TK-Glitch, Piotr Górski, Hamad Al Marri and, Con Kolivas and Alfred Chen. 

# Version

- stable : 5.10.3
- mainline : 5.10-rc7

# Build 

    git clone https://github.com/kevall474/linux-pkg
    cd linux-pkg
    env _release=(1 or 2) _cpu_sched=(1,2,3,4,5 or 6) _compiler=(1,2,3 or 4) makepkg -s
    
## Install

    sudo pacman -U linux-kernel-(optional if cpu sched selected : cachy,cacule,muqss,bmq,pds,upds)
    sudo pacman -U linux-kernel-(optional if cpu sched selected : cachy,cacule,muqss,bmq,pds,upds)-headers
    or
    sudo pacman -U mainline-kernel-(optional if cpu sched selected : cachy,cacule,muqss,bmq,pds,upds)
    sudo pacman -U mainline-kernel-(optional if cpu sched selected : cachy,cacule,muqss,bmq,pds,upds)-headers

## Build variables

### _release

- Variable is required!
- Will select the release of the kernel :

        1 : Latest stable release
        2 : Latest mainline release

### _cpu_sched

- Optional variable
- Will add a CPU Scheduler if you want :

        1 : Cachy by Hamad Al Marri
        2 : CacULE by Hamad Al Marri
        3 : MuQSS by Con Kolivas
        4 : BMQ by Alfred Chen
        5 : PDS by Alfred Chen
        6 : UPDS by TK-Glitch based on the work by Alfred Chen

Leave this variable empty if you don't want to add a CPU Scheduler.

### _compiler

- Optional variable
- Will set compiler to build the kernel :

        1 : GCC
        2 : GCC+LLVM
        3 : CLANG
        4 : CLANG+LLVM
        
If not set it will build with CLANG+LLVM by default.
 
