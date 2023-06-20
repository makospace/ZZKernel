#include <xbook/memcache.h>
#include <xbook/debug.h>
#include <xbook/hardirq.h>
#include <xbook/softirq.h>
#include <xbook/clock.h>
#include <xbook/virmem.h>
#include <xbook/task.h>
#include <xbook/schedule.h>
#include <xbook/sharemem.h>
#include <xbook/msgqueue.h>
#include <xbook/sem.h>
#include <xbook/syscall.h>
#include <xbook/fifo.h>
#include <xbook/driver.h>
#include <xbook/walltime.h>
#include <xbook/fs.h>
#include <xbook/timer.h>
#include <xbook/initcall.h>
#include <xbook/mutexqueue.h>
#include <xbook/account.h>
#include <xbook/portcomm.h>
#include <xbook/disk.h>
#ifdef CONFIG_NET
#include <xbook/net.h>
#endif

#ifdef CONFIG_DWIN
#include <dwin/dwin.h>
#endif

int kernel_main(void)
{
    keprint(PRINT_INFO "welcome to xbook kernel.\n");
    mem_caches_init();
    vir_mem_init();
    irq_description_init();
    softirq_init();
    syscall_init();
    share_mem_init();
    msg_queue_init();
    sem_init();
    fifo_init();
    schedule_init();
    tasks_init();
    mutex_queue_init();
    clock_init();
    timers_init();
    walltime_init();
    interrupt_enable();
    driver_framewrok_init();
    disk_init();
    initcalls_exec();
#ifdef CONFIG_DEVICE_TEST
    drivers_print_mini();
    while (1);
#endif
    file_system_init();
#ifdef CONFIG_NET
    network_init();
#endif
    account_manager_init();
    port_comm_init();
#ifdef CONFIG_DWIN
    dwin_init();
#endif
    task_start_user();
    return 0;    
}
