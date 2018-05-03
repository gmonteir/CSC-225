#include <stdio.h>
#include "stack.h"

int main()
{
   char ch;
   int done = 0, f = 0, skip = 0, stack[10], num, res;
   int *bp, *sp, *save_f = &f, *n = &num;

   bp = stack - 1;
   sp = bp;

   printf("Welcome to the stack program.\n");

   while (!done)
   {
      printf("\nEnter option: ");
      scanf(" %c", &ch);

      if (ch == 'u')
      {
         printf("What number? ");
         scanf(" %d", &num);
         sp++;
         res = push(num, sp, bp);

         if (res == 1)
         {
            sp--;
            printf("Overflow!!!\n");
         }
      }
      else if (ch == 'o')
      {
         res = pop(n, sp, bp);
         sp--;

         if (res == 1)
         {
            sp++;
            printf("Underflow!!!\n");
         }
         else
         {
            printf("Popped %d\n", num);
         }
      }
      else if (ch == 'd')
      {
         f = 0;
      }
      else if (ch == 'h')
      {
         f = 1;
      }
      else if (ch == 'c')
      {
         f = 2;
      }
      else if (ch == 'x')
      {
         printf("Goodbye!\n");
         break;
      }
      else
      {
         skip = 1;
      }

      if (!skip)
      {
         printf("Stack: ");
         print_stack(f, sp, bp, save_f);
      }
      else
      {
         skip = 0;
         printf("\n");
      }
   }

   return 0;
}
