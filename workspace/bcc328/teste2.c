#include <stdio.h>

int main() {
  int a;

  {
    const int x = 1;
    a = x + 1;
    printf("%d\n", a);
    {
      const int x = 5;
      a = x - 1;
      printf("%d\n", a);
    }

    printf("%d\n", x);
  }

  return 0;
}
