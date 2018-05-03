#include <stdio.h>

int push(int value, int *sp, int *bp);
int pop(int *value, int *sp, int *bp);
void print_stack(int format, int *sp, int *bp, int *save_format);