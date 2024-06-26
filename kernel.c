#ifdef OPT1

//Remove using of middle table
#include <stdlib.h> // malloc , free
#include <math.h>   // pow
#include <stdio.h>

void kernel(unsigned n, const double a[n][n],double b[n][n])

{
    printf("Je suis OPT1!\n");
    unsigned i, j;
    for (j = 0; j < n; j++)
    {
        for (i = 0; i < n; i++)
        {
            if (i < j)
            {
                 b[i][j] = pow(a[i][j], 0.0);
            }
            else if (i > j)
            {
                 b[i][j] = pow(a[i][j], 2.0);
            }
            else
            {
                 b[i][j] = pow(a[i][j], 1.0);
            }
        }
    }
}

#elif defined OPT2
//Remove using the pow function
#include <stdlib.h> // malloc , free
#include <math.h>   // pow
#include <stdio.h>

void kernel(unsigned n, const double a[n][n],double b[n][n])

{
    printf("Je suis OPT2!\n");
    unsigned i, j;
    for (j = 0; j < n; j++)
    {
        for (i = 0; i < n; i++)
        {
            if (i < j)
            {
                 b[i][j] = 1;
            }
            else if (i > j)
            {
                 b[i][j] = a[i][j] * a[i][j];
            }
            else
            {
                 b[i][j] = a[i][j];
            }
        }
    }
}


#elif defined OPT3
/* Inversion de boocle */

#include <stdlib.h> // malloc , free
#include <math.h>   // pow
#include <stdio.h>

void kernel(unsigned n, const double a[n][n],double b[n][n])

{
    printf("Je suis OPT3!\n");
    unsigned i, j;
    double(*c)[n] = malloc(n * n * sizeof c[0][0]);
    for (i = 0; i < n; i++)
    {
        for (j = 0; j < n; j++)
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
        for (j = 0; j < n; j++)
        {
            b[i][j] = pow(a[i][j], c[i][j]);
        }
    }
}

#elif defined OPT4
/* Inversion de boocle + OPT1 et OPT2*/

#include <stdlib.h> // malloc , free
#include <math.h>   // pow
#include <stdio.h>

void kernel(unsigned n, const double a[n][n],double b[n][n])

{
    printf("Je suis OPT4!\n");
    unsigned i, j;
    for (i = 0; i < n; i++)
    {
        for (j = 0; j < n; j++)
        {
            if (i < j)
            {
                 b[i][j] = 1;
            }
            else if (i > j)
            {
                 b[i][j] = a[i][j] * a[i][j];
            }
            else
            {
                 b[i][j] = a[i][j];
            }
        }
    }
}


#elif defined OPT5
/* Élimination des conditions */
#include <stdlib.h> // malloc , free
#include <math.h> // pow

void kernel(unsigned n, const double a[n][n],double b[n][n])
{
    unsigned i, j;
    for (i = 0; i < n; i++)
    {
        for (j = 0; j < i ; j++)
        {
            b[i][j] = a[i][j] * a[i][j];
        }
        for (j = i+1; j < n ; j++)
        {
            b[i][j] = 1;
        }

        b[i][i] = a[i][i];
    }
}



#else
/* original */

#include <stdlib.h> // malloc , free
#include <math.h>   // pow
#include <stdio.h>

void kernel(unsigned n, const double a[n][n],double b[n][n])

{
    printf("Je suis le main!\n");
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

#endif
