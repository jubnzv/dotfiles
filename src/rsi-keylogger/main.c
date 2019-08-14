#include <errno.h>
#include <fcntl.h>
#include <linux/input.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define LOG_FP "/home/jubnzv/Org/kbd.csv"
#define DEV_FP "/dev/input/by-path/platform-i8042-serio-0-event-kbd"

int main(int argc, char **argv)
{
    int dev_fd;
    FILE *log_fp;
    struct input_event ev;

    dev_fd = open(DEV_FP, O_RDONLY);
    if (dev_fd == -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }

    log_fp = fopen(LOG_FP, "a");
    if (log_fp == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }

    for (;;) {
        read(dev_fd, &ev, sizeof(struct input_event));

        if (ev.type == 1) {
            // ev.value:
            // 0 - key released
            // 1 - key pressed
            // 2 - holding key
            fprintf(log_fp, "%ld,%d,%d\n", ev.time.tv_sec, ev.code, ev.value);
        }
    }

    exit(EXIT_SUCCESS);
}
