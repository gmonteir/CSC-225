#include "stack.h"

int push(int value, int *sp, int *bp)
{
   if (sp - bp > 10)
   {
      return 1;
   }

   *sp = value;
   return 0;
}

int pop(int *value, int *sp, int *bp)
{
   if (sp <= bp)
   {
      return 1;
   }

   *value = *sp;
   return 0;
}

void print_stack(int format, int *sp, int *bp, int *save_format)
{
   int *i;
    
   if (format == 0)
   {
      for (i = bp + 1; i <= sp; i++)
      {
         printf("%d ", *i);
      }

      *save_format = 0;
   }
   else if (format == 1)
   {
      for (i = bp + 1; i <= sp; i++)
      {
         printf("%x ", *i);
      }

      *save_format = 1;
   }
   else if (format == 2)
   {
      for (i = bp + 1; i <= sp; i++)
      {
         printf("%c ", *i);
      }

      *save_format = 2;
   }

   printf("\n");
}
