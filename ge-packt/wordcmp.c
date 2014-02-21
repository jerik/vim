/* ------------------------------------------------------------------- */
/*
compare words of two texts;
(C) R.Wobst, @(#) 14.Nov 2001

usage:

1. put (or link) both files into current directory
2. for convenience, remove files tmp* in current directory
3. type
   wordcmp file1 file2
4. type
   less -r tmp*.file1
   (or ...file2).

   Under Linux and xterms, we recommend instead

   less -P : -R tmp*.file1

   The results are marked as follows:

   white:	unchanged
   green:	some phrase was added here in file2
   yellow:	phrase was changed in file2
   red:		phrase was deleted in file2

   The differences are not fully reliable - only words are compared
   (other differences are not noted), and the output of diff is not
   always optimal (but quite good).

Compilation:

cc -O wordcmp.c -lcurses -o wordcmp

Linux: maybe "-lncurses" necessary

HP-UX 11: cc -O -D_XOPEN_SOURCE_EXTENDED -D__10_10_COMPAT_CODE
	(colors fail; apparently strange curses)

The program is based on the structure of output of the diff-command:
"Headlines" must have the form as described in write_markfile(), 
followed by lines beginning with '<' resp. '>' and separated by some
line containing "---" only. In the case of different output, you must
edit write_markfile().
*/
/* ------------------------------------------------------------------- */

#include <curses.h>
#include <term.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <string.h>
#include <malloc.h>
#include <locale.h>

#define READ	0
#define WRITE	1
#define MAXCNT	100000		/* not more than 100.000 words */

static void write_wordlist(), write_markfile(),
	    mark(), cwrite(), fatal();

static char *tmp_nam(), *comp_term();

static FILE *myfopen();

/* ------------------------------------------------------------------- */

main(argc, argv)
  char *argv[];
  {
   char *tmp1, *tmp2, *tmpd1, *tmpd2, buf[256];
   int off1[MAXCNT+1], off2[MAXCNT+1];
   FILE *fpi1, *fpi2, *fpo1, *fpo2, *fpd;

   if(argc != 3) fatal("usage: %s file1 file2", argv[0]);
   setlocale(LC_ALL, "");

   fpi1 = myfopen(argv[1], READ); fpi2 = myfopen(argv[2], READ);
   fpo1 = myfopen(tmp1 = tmp_nam(argv[1]), WRITE);
   fpo2 = myfopen(tmp2 = tmp_nam(argv[2]), WRITE);

   write_wordlist(fpi1, fpo1, off1);
   write_wordlist(fpi2, fpo2, off2);

   sprintf(buf,
	  "diff %.100s %.100s >%.100s\n",
	   tmp1, tmp2, tmpd1 = tmp_nam("1"));

   system(buf);

   sprintf(buf,
	  "diff %.100s %.100s >%.100s\n",
	   tmp2, tmp1, tmpd2 = tmp_nam("2"));

   system(buf);

   fpd = myfopen(tmpd1, READ);
   write_markfile(fpi1, fpo1, fpd, off1);
   unlink(tmpd1); fclose(fpd);

   fpd = myfopen(tmpd2, READ);
   write_markfile(fpi2, fpo2, fpd, off2);
   unlink(tmpd2); fclose(fpd);

   return 0;
  }

/* ------------------------------------------------------------------- */
/* open file for read or write (flag == READ oder flag == WRITE) with
   error test
*/

static FILE *myfopen(name, flag)
  char *name;
  {
   FILE *fp;

   if((fp = fopen(name, flag == READ ? "r" : "w")) == NULL)
      fatal(flag == READ ?
	    "cannot open file %s for read" : "cannot open file %s for write",
	    name);

   return fp;
  }

/* ------------------------------------------------------------------- */
/* generate very personal tempfile name */

static char *tmp_nam(patt)
  char *patt;
  {
   char *s;

   if((s = (char *)malloc(strlen(patt) + 10)) == NULL)
     {fatal("tmpnam(%s) - cannot allocate heap", patt); exit(1);}

   sprintf(s, "tmp.%s", patt);
   return s;
  }

/* ------------------------------------------------------------------- */
/* extract words (consisting of alnum-characters only) from file fpi
   and write them to file fpo; put offset of n-th word into integer
   field off[n]
*/

static void write_wordlist(fpi, fpo, off)
  FILE *fpi, *fpo;
  int *off;
  {
   int bcnt, icnt, flag, c;

   bcnt = icnt = flag = 0;

   while ((c = getc(fpi)) != EOF)
     {
      if(flag ^ !!isalnum(c))
	{
	 if(flag) putc('\n', fpo);

	 if(flag ^= 1)
	   {
	    off[icnt++] = bcnt;
	    if(icnt == MAXCNT)
	      {
	       fprintf(stderr, "abort - increase MAXCNT = %d!\n", MAXCNT);
	       exit(1);
	      }
	   }
	}

      if(flag) putc(c, fpo);
      ++bcnt;
     }

   off[icnt] = -1;		/* mark end */
   if(flag) putc('\n', fpo);
   fflush(fpo);
  }

/* ------------------------------------------------------------------- */
/* extract informations written by command 'diff' into file fpd;
   select only lines of form

   number[,number]<letter>...

   where <letter> = a, c, d;

   copy file fpi to fpo but write appropriate marks (dependent on <letter>)
   at byte offsets taken from field off[]
*/

static void write_markfile(fpi, fpo, fpd, off)
  FILE *fpi, *fpo, *fpd;
  int *off;
  {
   char *p, buf[256];
   int c, l1, l2, cnt;

   rewind(fpi); rewind(fpo); rewind(fpd);
   cwrite(fpi, NULL, 0);		/* reset internal counter */
   mark(fpo, 'R');			/* set "white on black" */
   cnt = 1;

   while(fgets(buf, 255, fpd) != NULL)
     {
      /* test for lines to skip */
      if(*buf == '<' || *buf == '>') continue;
      if(!strcmp(buf, "---\n")) continue;

      /* get kind of change and replace it by space */
      if((p = strpbrk(buf, "acd")) == NULL) goto internal;
      c = *p; *p = ' ';

      /* obtain line numbers */
      if(sscanf(buf, "%d,%d", &l1, &l2) == 2);
      else if(sscanf(buf, "%d ", &l1) == 1) l2 = l1;
      else goto internal;
      
      /* write until change mark */
      cwrite(fpi, fpo, off[l1-1]);

      /* mark the place by color */
      switch(c)
	{
	 case 'a': case 'd': case 'c': mark(fpo, c); break;
	 default: fatal("illegal line in diff file: %s", buf);
	}

      /* write evtl. following words in new color */
      cwrite(fpi, fpo, off[l2]);

      /* reset color */
      mark(fpo, 'R');

      ++cnt;
     }

   cwrite(fpi, fpo, -1);	/* write rest of file (if any) */
   mark(fpo, 'E');		/* reset colors */

   return;

internal:
   fprintf(stderr, "line %d: ", cnt);
   fatal("illegal line in diff file: %s", buf);
  }

/* ------------------------------------------------------------------- */
/* write bytes from file fpi to fpo until offset 'off' is reached;
   if off < 0, copy until end of file fpi
   if fpo == NULL the internal counter boff is reset
*/

static void cwrite(fpi, fpo, off)
  FILE *fpi, *fpo;
  {
   static boff = 0;
   int c;

   if(fpo == NULL) {boff = 0; return;}

   if(off < 0) {while((c = getc(fpi)) != EOF) putc(c, fpo); return;}
   while(boff < off) {putc(getc(fpi), fpo); ++boff;}
  }

/* ------------------------------------------------------------------- */
/* set appropriate colors for changed words (depending on character 'flag');
   flag = R: reset color to white on black, non-bold mode
   flag = E: output capability "sgr0" (normal state)
*/

static void mark(fp, flag)
  FILE *fp;
  int flag;
  {
   static char *green, *red, *yellow, *reset, *bold, *sgr0;
   static first = 1;

   if(first)
     {
      char *setaf, *setab, buf[256];

      first = 0;
      setupterm((char *)0, 1, (int *)0);
      setaf = comp_term("setaf");
      setab = comp_term("setab");
      bold = comp_term("bold");
      sgr0 = comp_term("sgr0");

      sprintf(buf, "%s%s", bold, tparm(setaf, COLOR_GREEN));
      green = strdup(buf);
      sprintf(buf, "%s%s", bold, tparm(setaf, COLOR_YELLOW));
      yellow = strdup(buf);
      sprintf(buf, "%s%s", bold, tparm(setaf, COLOR_RED));
      red = strdup(buf);
      reset = strdup(tparm(setab, COLOR_BLACK));
      sprintf(buf, "%s%s%s", sgr0, reset, tparm(setaf, COLOR_WHITE));
      reset = strdup(buf);
     }

   switch(flag)
     {
      case 'a': fputs(green, fp); return;	/* appended */
      case 'd': fputs(red, fp); return;		/* deleted */
      case 'c': fputs(yellow, fp); return;	/* changed */
      case 'R': fputs(reset, fp); return;	/* neutral */
      case 'E': fputs(sgr0, fp); return;	/* reset term */
     }
  }

/* ------------------------------------------------------------------- */
/* compute terminfo capability cap */

static char *comp_term(cap)
  char *cap;
  {
   char *s;

   s = tigetstr(cap);

   if(!(int)s || (int)s == -1)
      fatal("terminfo capability %s not defined", cap);

   return s;
  }

/* ------------------------------------------------------------------- */
/* error message with one string argument */

static void fatal(s, t)
  char *s, *t;
  {
   char buf[256];

   sprintf(buf, s, t);
   fprintf(stderr, "%s - abort!\n", buf);
   exit(1);
  }

/* ------------------------------------------------------------------- */
