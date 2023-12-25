#include <ulib.h>
#include <unistd.h>
#include <file.h>
#include <stat.h>

int main(int argc, char *argv[]);

static int
initfd(int fd2, const char *path, uint32_t open_flags)
{
    int fd1, ret;
    if ((fd1 = open(path, open_flags)) < 0)
    {
        return fd1;
    }
    // 我们希望文件描述符是fd2, 但是分配的fd1如果不等于fd2, 就需要做一些处理
    if (fd1 != fd2)
    {
        close(fd2);
        ret = dup2(fd1, fd2); // 通过sys_dup让两个文件描述符指向同一个文件
        close(fd1);
    }
    return ret;
}

void umain(int argc, char *argv[])
{
    int fd;
    // 0用于描述stdin，这里因为第一个被打开，所以stdin会分配到0
    if ((fd = initfd(0, "stdin:", O_RDONLY)) < 0)
    {
        warn("open <stdin> failed: %e.\n", fd);
    }
    // 1用于描述stdout
    if ((fd = initfd(1, "stdout:", O_WRONLY)) < 0)
    {
        warn("open <stdout> failed: %e.\n", fd);
    }
    int ret = main(argc, argv); // 真正的“用户程序”
    exit(ret);
}
