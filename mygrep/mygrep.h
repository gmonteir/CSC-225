#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void read_file(char *fname, char *word);
struct list* initialize();
struct node* create(char *line, int line_num, int location, struct node* next, struct node* prev);
struct list* append(struct list* in, char *line, int line_num, int location);
void dispose(struct list* in);
void print_lines(struct list* in);

typedef struct node
{
   char *line;
   int line_num;
   int location;
   struct node *next;
   struct node *prev;
} node;

typedef struct list
{
   struct node *head;
   struct node *tail;
   int length;
} list;