# Otus Homework 11. Управление процессами
### Цель домашнего задания
Работать с процессами
### Описание домашнего задания
- Написать свою реализацию **ps -ax** используя анализ */proc*  
Результат ДЗ - рабочий скрипт который можно запустить  
- Написать свою реализацию **lsof**
Результат ДЗ - рабочий скрипт который можно запустить  
- Дописать обработчики сигналов в прилагаемом скрипте, оттестировать, приложить сам скрипт, инструкции по использованию  
Результат ДЗ - рабочий скрипт который можно запустить + инструкция по использованию и лог консоли  
- Реализовать 2 конкурирующих процесса по IO. пробовать запустить с разными *ionice*  
Результат ДЗ - скрипт запускающий 2 процесса с разными *ionice*, замеряющий время выполнения и лог консоли  
- Реализовать 2 конкурирующих процесса по CPU. пробовать запустить с разными *nice*  
Результат ДЗ - скрипт запускающий 2 процесса с разными *nice* и замеряющий время выполнения и лог консоли  

## Выволнение
### Написать свою реализацию ps -ax
Результат выполнения задания - скрипт *ps.sh*. Он обрабатывает содержимое файла */proc/\*/status* и выводит таблицу на экран. Примерный вывод скрипта:
```bash
PID     STAT            NAME
1       S (sleeping)    systemd
2       S (sleeping)    kthreadd
3       I (idle)        rcu_gp
4       I (idle)        rcu_par_gp
5       I (idle)        slub_flushwq
6       I (idle)        netns
8       I (idle)        kworker/0:0H-events_highpri
10      I (idle)        mm_percpu_wq
11      S (sleeping)    rcu_tasks_rude_
12      S (sleeping)    rcu_tasks_trace
13      S (sleeping)    ksoftirqd/0
14      I (idle)        rcu_sched
15      S (sleeping)    migration/0
16      S (sleeping)    idle_inject/0
18      S (sleeping)    cpuhp/0
19      S (sleeping)    cpuhp/1
20      S (sleeping)    idle_inject/1
21      S (sleeping)    migration/1
22      S (sleeping)    ksoftirqd/1
24      I (idle)        kworker/1:0H-events_highpri
25      S (sleeping)    kdevtmpfs
26      I (idle)        inet_frag_wq
27      S (sleeping)    kauditd
28      S (sleeping)    khungtaskd
29      S (sleeping)    oom_reaper
30      I (idle)        writeback
31      S (sleeping)    kcompactd0
32      S (sleeping)    ksmd
33      S (sleeping)    khugepaged
38      I (idle)        kworker/1:1-events
80      I (idle)        kintegrityd
81      I (idle)        kblockd
82      I (idle)        blkcg_punt_bio
83      I (idle)        tpm_dev_wq
84      I (idle)        ata_sff
85      I (idle)        md
86      I (idle)        edac-poller
87      I (idle)        devfreq_wq
88      S (sleeping)    watchdogd
90      I (idle)        kworker/0:1H-kblockd
...
```
### Написать свою реализацию lsof
Результат выполнения задания - скрипт *lsof.sh*. Он обрабатывает содержимое файлов */proc/\*/status*, */proc/\*/stat*, */proc/\*/fd* и */proc/\*/maps* и выводит таблицу на экран. Примерный вывод скрипта:
```bash
COMMAND PID     NAME
systemd 1       /dev/null
systemd 1       /dev/null
systemd 1       /proc/1/mountinfo
systemd 1       socket:[19493]
systemd 1       socket:[19231]
systemd 1       socket:[18844]
systemd 1       socket:[18384]
systemd 1       socket:[18375]
systemd 1       socket:[21978]
systemd 1       anon_inode:inotify
systemd 1       socket:[17971]

...
systemd 1       /usr/lib/x86_64-linux-gnu/libgcrypt.so.20.3.4
systemd 1       /usr/lib/x86_64-linux-gnu/libgpg-error.so.0.32.1
systemd 1       /usr/lib/x86_64-linux-gnu/libip4tc.so.2.0.0
systemd 1       /usr/lib/x86_64-linux-gnu/libkmod.so.2.3.7
systemd 1       /usr/lib/x86_64-linux-gnu/liblz4.so.1.9.3
systemd 1       /usr/lib/x86_64-linux-gnu/liblzma.so.5.2.5
systemd 1       /usr/lib/x86_64-linux-gnu/libmount.so.1.1.0
systemd 1       /usr/lib/x86_64-linux-gnu/libpam.so.0.85.1
systemd 1       /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0.10.4
systemd 1       /usr/lib/x86_64-linux-gnu/libseccomp.so.2.5.3
systemd 1       /usr/lib/x86_64-linux-gnu/libselinux.so.1
systemd 1       /usr/lib/x86_64-linux-gnu/libzstd.so.1.4.8
systemd-journal 338     /dev/null
systemd-journal 338     /dev/null
systemd-journal 338     socket:[18149]
systemd-journal 338     /proc/sys/kernel/hostname
systemd-journal 338     anon_inode:[signalfd]
systemd-journal 338     anon_inode:[signalfd]
systemd-journal 338     anon_inode:[signalfd]
systemd-journal 338     socket:[18151]
systemd-journal 338     anon_inode:[timerfd]
systemd-journal 338     socket:[18375]
...
```

### Дописать обработчики сигналов в прилагаемом скрипте
В скрипт *myfork.py* добавлены обработчики сигналов **SIGINT**, **SIGTERM**, **SIGALRM**, **SIGUSR1** и **SIGUSR2**
```python
import signal

def sigint_handler(signum, frame):
    print("SIGINT signal recieved. Exiting...")
    sys.exit(0)
def sigtrm_handler(signum, frame):
    print("SIGTERM signal received. Exiting...")
    sys.exit(0)
def sigalarm_handler(signum, frame):
    print("!!!!!!!!!!!!!!!! SIGALRM signal received !!!!!!!!!!!!!!!!")
def sigusr1_handler(signal, frame):
    print("SIGUSR1 signal received. Doing something...")
def sigusr2_handler(signal, frame):
    print("SIGUSR2 signal received. Doing something else...")

signal.signal(signal.SIGINT, sigint_handler)
signal.signal(signal.SIGTERM, sigtrm_handler)
signal.signal(signal.SIGALRM, sigalarm_handler)
signal.signal(signal.SIGUSR1, sigusr1_handler)
signal.signal(signal.SIGUSR2, sigusr2_handler)
signal.alarm(5)
```
**SIGALRM:** Через 5 секунд выводится сообщение `!!!!!!!!!!!!!!!! SIGALRM signal received !!!!!!!!!!!!!!!!`  
**SIGINT**: При нажатии комбинации `Ctrl+C` появляется сообщение `SIGINT signal recieved. Exiting...`, и скрипт завершается  
**SIGTERM**: При вводе команды `kill <PID>` появляется сообщение `SIGTERM signal recieved. Exiting...`, и скрипт завершается  
**SIGUSR1**: При вводе команды `kill -SIGUSR1 <PID>` появляется сообщение `SIGUSR1 signal received. Doing something...`  
**SIGUSR2**: При вводе команды `kill -SIGUSR2 <PID>` появляется сообщение `SIGUSR2 signal received. Doing something else...`  

### Реализовать 2 конкурирующих процесса по IO. пробовать запустить с разными ionice
Скрипт *io.sh* одновременно начинает разархивировать два одинаковых архива с разными значениями *ionice*. По окончании работы скрипта на экран выводится статистика. Как видно, процесс с наивысшим приоритетом *ionice* выполнился быстрее.
```bash
Generating temporary files...
Copying temporary files...
Creating archives...
Starting both processes...

All processes finished

Process HighPriority started at 13:00:53

Process HighPriority finished at 13:00:59

real   0m5.284s
user   0m0.011s
sys 0m2.450s

Process LowPriority started at 13:00:53

Process LowPriority finished at 13:01:03

real   0m9.885s
user   0m0.023s
sys 0m3.179s
```
### Реализовать 2 конкурирующих процесса по CPU. пробовать запустить с разными nice
Скрипт *cpu.sh* одновременно запускает 2 процесса, выполняющих команду `dd if=/dev/urandom of=/dev/null bs=4096 count=100000` с разными значениями *nice*. По окончании работы скрипта на экран выводится статистика. Как видно, процесс с наивысшим приоритетом *nice* выполнился быстрее.
```bash
High Priority Process started
Low Priority Process started

All processes finished

Process HighPriority started at 12:24:23

Process HighPriority finished at 12:24:25

real    0m1.897s
user    0m0.021s
sys     0m1.811s

Process LowPriority started at 12:24:23

Process LowPriority finished at 12:24:27

real    0m3.832s
user    0m0.037s
sys     0m1.850s

```
