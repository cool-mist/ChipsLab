#include <unistd.h>
#include <iostream>

int main()
{
    std::cout << sysconf(_SC_OPEN_MAX) << std::endl;
}
