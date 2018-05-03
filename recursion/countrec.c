#include <stdio.h>
#include <string.h>

void count_backward_from(int x);
void count_forward_to(int x);
int char_count(char *word, char search);

int main()
{
   int num, result;
   char search, *word;

   printf("Input a number: ");
   scanf(" %d", &num);
   count_backward_from(num);
   printf("\n");
   count_forward_to(num);

   printf("\nInput a word: ");
   scanf(" %[^\n]%*c", word);
   printf("Character to search for: ");
   scanf(" %c", &search);
   result = char_count(word, search);
   printf("Occurs %d times!\n", result);
}

void count_backward_from(int x)
{
   if (x > 1)
   {
      printf("%d, ", x);
      count_backward_from(x - 1);
   }
   else
   {
      printf("%d", x);
   }
}

void count_forward_to(int x)
{
   if (x > 0)
   {
      count_forward_to(x - 1);
      
      if (x == 1)
      {
         printf("%d", x);
      }
      else
      {
         printf(", %d", x);
      }
   }
}

int char_count(char *word, char search)
{
   int len = strlen(word);

   if (len == 0)
   {
      return 0;
   }

   char sub[len];
   strcpy(sub, &word[1]);
   sub[len] = '\0';

   if (word[0] == search)
   {
      return 1 + char_count(sub, search);
   }

   return char_count(sub, search);
}