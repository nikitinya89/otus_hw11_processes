# Otus Homework 11. Управление процессами
### Цель домашнего задания
Работать с процессами
### Описание домашнего задания
1. Написать свою реализацию **ps -ax** используя анализ */proc*  
Результат ДЗ - рабочий скрипт который можно запустить  
2. Написать свою реализацию **lsof**
Результат ДЗ - рабочий скрипт который можно запустить  
3. Дописать обработчики сигналов в прилагаемом скрипте, оттестировать, приложить сам скрипт, инструкции по использованию  
Результат ДЗ - рабочий скрипт который можно запустить + инструкция по использованию и лог консоли  
4. Реализовать 2 конкурирующих процесса по IO. пробовать запустить с разными *ionice*  
Результат ДЗ - скрипт запускающий 2 процесса с разными *ionice*, замеряющий время выполнения и лог консоли  
5. Реализовать 2 конкурирующих процесса по CPU. пробовать запустить с разными *nice*  
Результат ДЗ - скрипт запускающий 2 процесса с разными *nice* и замеряющий время выполнения и лог консоли  

## Выволнение
### Написать свою реализацию ps -ax
Результат выполнения задания - скрипт *ps.sh*. Он обрабатывает содержимое файла /proc/*/status и выводит таблицу на экран. Примерный вывод скрипта:
```
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
