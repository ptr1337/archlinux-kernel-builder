# linux-pkg

Linux kernel build for Archlinux with a patch set by TK-Glitch, Piotr Górski, Hamad Al Marri, Con Kolivas and Alfred Chen. 

# Version

- stable : 5.10.13

- trunk-incomplete : 5.11 and the 3 package that will build is : linux-kernel-pds, linux-kernel-bmq and linux-kernel-muqss (patches for cacule, cacule-rdb and cachy are not ready yet). MuQSS patches are 5.10 kernel version, but apply with succes.

# Build 

    git clone https://github.com/kevall474/linux-pkg
    cd linux-pkg
    env _cpu_sched=(1,2,3,4,5,6 or 7) _compiler=(1,2,3 or 4) makepkg -s
    
## Install

    sudo pacman -U linux-kernel-(optional if cpu sched selected : cachy,cacule,muqss,bmq,pds,upds,cacule-rdb)
    sudo pacman -U linux-kernel-(optional if cpu sched selected : cachy,cacule,muqss,bmq,pds,upds,cacule-rdb)-headers

## Build variables

### _cpu_sched

- Will add a CPU Scheduler if you want :

        1 : Cachy by Hamad Al Marri
        2 : CacULE by Hamad Al Marri
        3 : MuQSS by Con Kolivas
        4 : BMQ by Alfred Chen
        5 : PDS by Alfred Chen
        6 : UPDS by TK-Glitch based on the work by Alfred Chen
        7 : CacULE-rdb by Hamad Al Marri

Leave this variable empty if you don't want to add a CPU Scheduler.

### _compiler

- Will set compiler to build the kernel :

        1 : GCC
        2 : GCC+LLVM
        3 : CLANG
        4 : CLANG+LLVM
        
If not set it will build with CLANG+LLVM by default.

# CPU Scheduler

## Cahy CPU Scheduler

![cachy-logo](https://user-images.githubusercontent.com/68618182/99130896-a6204700-25df-11eb-9f08-5662a71fa273.png)

### Info

Cachy-sched is a linux scheduler that is based on Highest Response Ratio Next (HRRN) policy.
About Cachy Scheduler

- Each CPU has its own runqueue.
- NORMAL runqueue is a linked list of sched_entities (instead of RB-Tree).
- RT and other runqueues are just the same as the CFS's.
- A task gets preempted when any task in the runqueue has a higher HRRN.
- Wake up tasks preempt currently running tasks if its HRRN value is higher.
- This scheduler is designed for desktop usage since it is about responsiveness.
- Cachy might be good for mobiles or Android since it has high responsiveness, but it needs to be integrated to Android, I don't think the current version it is ready to go without some tweeking and adapting to Android hacks.

## CacULE CPU Scheduler

![cacule_sched](https://user-images.githubusercontent.com/68618182/103179297-92ac0100-4858-11eb-83aa-8992f33d67f8.png)

CacULE is a newer version of Cachy. The CacULE CPU scheduler is based on interactivity score mechanism. 
The interactivity score is inspired by the ULE scheduler (FreeBSD scheduler).

About CacULE Scheduler

- Each CPU has its own runqueue.
- NORMAL runqueue is a linked list of sched_entities (instead of RB-Tree).
- RT and other runqueues are just the same as the CFS's.
- Wake up tasks preempt currently running tasks if its interactivity score value is higher.


## MuQSS CPU Scheduler

MuQSS - The Multiple Queue Skiplist Scheduler by Con Kolivas.

MuQSS is a per-cpu runqueue variant of the original BFS scheduler with
one 8 level skiplist per runqueue, and fine grained locking for much more
scalability.

The goal of the Multiple Queue Skiplist Scheduler, referred to as MuQSS from
here on (pronounced mux) is to completely do away with the complex designs of
the past for the cpu process scheduler and instead implement one that is very
simple in basic design. The main focus of MuQSS is to achieve excellent desktop
interactivity and responsiveness without heuristics and tuning knobs that are
difficult to understand, impossible to model and predict the effect of, and when
tuned to one workload cause massive detriment to another, while still being
scalable to many CPUs and processes.

MuQSS is best described as per-cpu multiple runqueue, O(log n) insertion, O(1)
lookup, earliest effective virtual deadline first tickless design, loosely based
on EEVDF (earliest eligible virtual deadline first) and my previous Staircase
Deadline scheduler, and evolved from the single runqueue O(n) BFS scheduler.
Each component shall be described in order to understand the significance of,
and reasoning for it.

## BMQ CPU Scheduler

BitMap Queue CPU scheduler, referred to as BMQ from here on, is an evolution
of previous Priority and Deadline based Skiplist multiple queue scheduler(PDS),
and inspired by Zircon scheduler. The goal of it is to keep the scheduler code
simple, while efficiency and scalable for interactive tasks, such as desktop,
movie playback and gaming etc.

BMQ use per CPU run queue design, each CPU(logical) has it's own run queue,
each CPU is responsible for scheduling the tasks that are putting into it's
run queue.

The run queue is a set of priority queues. Note that these queues are fifo
queue for non-rt tasks or priority queue for rt tasks in data structure. See
BitMap Queue below for details. BMQ is optimized for non-rt tasks in the fact
that most applications are non-rt tasks. No matter the queue is fifo or
priority, In each queue is an ordered list of runnable tasks awaiting execution
and the data structures are the same. When it is time for a new task to run,
the scheduler simply looks the lowest numbered queueue that contains a task,
and runs the first task from the head of that queue. And per CPU idle task is
also in the run queue, so the scheduler can always find a task to run on from
its run queue.

Each task will assigned the same timeslice(default 4ms) when it is picked to
start running. Task will be reinserted at the end of the appropriate priority
queue when it uses its whole timeslice. When the scheduler selects a new task
from the priority queue it sets the CPU's preemption timer for the remainder of
the previous timeslice. When that timer fires the scheduler will stop execution
on that task, select another task and start over again.

If a task blocks waiting for a shared resource then it's taken out of its
priority queue and is placed in a wait queue for the shared resource. When it
is unblocked it will be reinserted in the appropriate priority queue of an
eligible CPU.

BMQ supports DEADLINE, FIFO, RR, NORMAL, BATCH and IDLE task policy like the
mainline CFS scheduler. But BMQ is heavy optimized for non-rt task, that's
NORMAL/BATCH/IDLE policy tasks.

## PDS CPU Scheduler

Priority and Deadline based Skiplist multiple queue scheduler, referred to as
PDS from here on, is developed upon the enhancement patchset VRQ(Variable Run
Queue) for BFS(Brain Fuck Scheduler by Con Kolivas). PDS inherits the existing
design from VRQ and inspired by the introduction of skiplist data structure
to the scheduler by Con Kolivas. However, PDS is different from MuQSS(Multiple
Queue Skiplist Scheduler, the successor after BFS) in many ways.

PDS is designed to make the cpu process scheduler code to be simple, but while
efficiency and scalable. Be Simple, the scheduler code will be easy to be read
and the behavious of scheduler will be easy to predict. Be efficiency, the
scheduler shall be well balance the thoughput performance and task interactivity
at the same time for different properties the tasks behave. Be scalable, the
performance of the scheduler should be in good shape with the glowing of
workload or with the growing of the cpu numbers.

PDS is described as a multiple run queues cpu scheduler. Each cpu has its own
run queue. A heavry customized skiplist is used as the backend data structure
of the cpu run queue. Tasks in run queue is sorted by priority then virtual
deadline(simplfy to just deadline from here on). In PDS, balance action among
run queues are kept as less as possible to reduce the migration cost. Cpumask
data structure is widely used in cpu affinity checking and cpu preemption/
selection to make PDS scalable with increasing cpu number.

# Update GRUB

    sudo grub-mkconfig -o /boot/grub/grub.cfg

# Contact info

kevall474@tuta.io if you have any problems or bugs report.

# Info 

You can refer to this Archlinux page that have lots of useful information to build the kernel and debugging if you have some issues https://wiki.archlinux.org/index.php/Kernel/Traditional_compilation
