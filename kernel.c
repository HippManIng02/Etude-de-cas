#include <stdlib.h> // malloc , free
#include <math.h>   // pow
void kernel(unsigned n, const double a[n][n],double b[n][n])

{
    unsigned i, j;
    double(*c)[n] = malloc(n * n * sizeof c[0][0]);
    for (j = 0; j < n; j++)
    {
        for (i = 0; i < n; i++)
        {
            if (i < j)
            {
                c[i][j] = 0.0;
            }
            else if (i > j)
            {
                c[i][j] = 2.0;
            }
            else
            {
                c[i][j] = 1.0;
            }
        }
        for (i = 0; i < n; i++)
        {
            b[i][j] = pow(a[i][j], c[i][j]);
        }
    }
    free(c);
}
