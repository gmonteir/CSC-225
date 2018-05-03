#define _SVID_SOURCE
#include "mygrep.h"

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf("myGrep: improper number of arguments\n");
        printf("Usage: ./mygrep <filename> <word>\n");
    }
    else if (access(argv[1], F_OK) == -1)
    {
        printf("Unable to open file: %s\n", argv[1]);
    }
    else
    {
        printf("./mygrep %s %s\n", argv[1], argv[2]);
        read_file(argv[1], argv[2]);
    }

    return 0;
}

void read_file(char *fname, char *word)
{
    char buffer[4096], longest[4096];
    int lines = 0, chars = 0;

    FILE *in = fopen(fname, "r");

    list* result = initialize();

    while (fgets(buffer, sizeof(buffer), in))
    {
        char *line = strdup(buffer);
        char *exists = strstr(buffer, word);

        if (strlen(buffer) > chars)
        {
            strcpy(longest, buffer);
            chars = strlen(buffer);
        }

        if (exists != NULL)
        {
            int position = 0;
            char *pch = strtok(buffer, " \n");

            while (pch != NULL)
            {
                if (strcmp(pch, word) == 0)
                {
                    result = append(result, line, lines, position);
                }

                pch = strtok(NULL, " \n");
                position++;
            }
        }

        lines++;
    }

    printf("longest line: %s", longest);
    printf("num chars: %d\n", chars);
    printf("num lines: %d\n", lines);
    printf("total occurrences of word: %d\n", result->length);

    print_lines(result);
    dispose(result);
}

struct list* initialize()
{
    list* new_list = (list*) malloc(sizeof(list));
    node* head = (node*) malloc(sizeof(node));
    node* tail = (node*) malloc(sizeof(node));

    head->line = "NULL";
    head->line_num = 0;
    head->location = 0;
    head->prev = NULL;

    tail->line = "NULL";
    tail->line_num = 0;
    tail->location = 0;
    tail->next = NULL;

    head->next = tail;
    tail->prev = head;

    new_list->head = head;
    new_list->tail = tail;

    return new_list;
}

struct node* create(char *line, int line_num, int location, struct node* next, struct node* prev)
{
    node* new_node = (node*) malloc(sizeof(node));
    
    if (new_node == NULL)
    {
        printf("Error creating a new node.\n");
        exit(0);
    }

    new_node->line = line;
    new_node->line_num = line_num;
    new_node->location = location;
    new_node->next = next;
    new_node->prev = prev;
 
    return new_node;
}

struct list* append(struct list* in, char *line, int line_num, int location)
{
    node* new_node = create(line, line_num, location, NULL, in->tail);
 
    in->tail->next = new_node;
    in->tail = new_node;
    in->length = in->length + 1;
    return in;
}

void dispose(struct list* in)
{
    node *cursor;
 
    if (in->tail != NULL)
    {
        cursor = in->tail;

        while (cursor != in->head)
        {
            in->tail = cursor->prev;
            free(cursor);
            cursor = in->tail;
        }
    }

    free(in->head);
    free(in);
}

void print_lines(struct list* in)
{
    node* cursor = in->head->next->next;

    while (cursor != NULL)
    {
        printf("line %d; word %d; %s", cursor->line_num, cursor->location, cursor->line);
        cursor = cursor->next;
    }
}
