#include <stdlib.h>

typedef struct carType Car;
Car* retp(Car *list);

struct carType
{
   int year;
   Car *next;
};

int main()
{
   Car* new_list = (Car*) malloc(sizeof(Car));
   retp(new_list);

   return 0;
}

Car* retp(Car *list)
{
   return list;
}