
/*
 * Copyright 2002 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

/*
 * Routines for manipulating a FIFO queue
 */

#include <stdlib.h>

#include "Myfifo.h"

typedef struct fifonode {
	int fn_id;
    char *fn_data;
	struct fifonode *fn_next;
};

typedef struct fifo {
	fifonode_t *f_head;
	fifonode_t *f_tail;
};

fifo_t * fifo_new(void)
{
	fifo_t *f;

	f = calloc(1,sizeof (fifo_t));

	return (f);
}

/* Add to the end of the fifo */
void fifo_add(fifo_t *f, char *data)
{
	fifonode_t *fn = malloc(sizeof (fifonode_t));
    
    char * split;
    split = strtok (data," =.-:");
    fn->fn_id = split;
	fn->fn_data = data;
	fn->fn_next = NULL;

	if (f->f_tail == NULL)
		f->f_head = f->f_tail = fn;
	else {
		f->f_tail->fn_next = fn;
		f->f_tail = fn;
	}
}


/* Remove from the front of the fifo */
int fifo_remove(fifo_t *f)
{
	fifonode_t *fn;
	char *data;

	if ((fn = f->f_head) == NULL)
		return 0;

	data = fn->fn_data;
	if ((f->f_head = fn->fn_next) == NULL)
		f->f_tail = NULL;

	free(fn);

	return 1;
}

/* Get id */
int fifo_getID(fifo_t *f)
{
	if (f->f_head == NULL) return (NULL);
	else {
        int id = f->f_head->fn_id;
        return id;
    }
}

/* Get string */
char * fifo_getString(fifo_t *f)
{
    fifonode_t *fn;
	char *data;
//    int id;
//    char idS[sizeof(int)];
	if ((fn = f->f_head) == NULL) return (NULL);
	else {
//        id = fn->fn_id;
        data = fn->fn_data;
        free(fn);
        return data;
//        sprintf(idS,"%d",id);
//        return strcat(idS,data);
    }
    
}