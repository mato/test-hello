#include <stdio.h>

int main(int argc, char *argv[])
{
    char *greeting = "World";

    if (argc == 2)
        greeting = argv[1];

    printf("Hello, %s!\n", greeting);
    return 0;
}
