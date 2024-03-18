#include <stdio.h>
#include <stdlib.h> // atoi, qsort
#include <stdint.h>

extern uint64_t rdtsc ();

// TODO: adjust for each kernel
extern void kernel (unsigned n, double a[n][n], double b[n][n]);

// TODO: adjust for each kernel
static void init_array (int n, double a[n][n]) {
   int i, j;

   for (i=0; i<n; i++)
      for (j=0; j<n; j++)
         a[i][j] = (double) rand() / RAND_MAX;
}

// TODO: adjust for each kernel
static void print_array (int n, double a[n][n], const char *output_file_name) {
   int i, j;

   FILE *fp = fopen (output_file_name, "w");
   if (fp == NULL) {
      fprintf (stderr, "Cannot write to %s\n", output_file_name);
      return;
   }

   for (i=0; i<n; i++)
      for (j=0; j<n; j++)
         fprintf (fp, "%lf\n", a[i][j]);

   fclose (fp);
}

int main (int argc, char *argv[]) {
   /* check command line arguments */
   if (argc != 3) {
      fprintf (stderr, "Usage: %s <size> <output file name>\n", argv[0]);
      return 1;
   }

   /* get command line arguments */
   const unsigned size = atoi (argv[1]); /* problem size */
   const char *output_file_name = argv[2];

   /* allocate arrays. TODO: adjust for each kernel */
   double (*a)[size] = malloc (size * size * sizeof a[0][0]);
   double (*b)[size] = malloc (size * size * sizeof b[0][0]);

   /* init arrays */
   srand(0);
   init_array (size, a);
   init_array (size, b);

   /* print output */
   kernel (size, a, b);
   print_array (size, b, output_file_name);

   /* free arrays. TODO: adjust for each kernel */
   free (a);
   free (b);
   
   return EXIT_SUCCESS;
}
