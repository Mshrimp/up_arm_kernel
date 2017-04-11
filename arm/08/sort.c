#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int cmp_char(const void *p1, const void *p2)
{
	if(*(const char *)p1 > *(const char *)p2)
		return 1;
	else
		return 0;
}

int main(int argc, char ** argv)
{
	if(argc != 2)
	{
		fprintf(stderr, "%s filename\n", argv[0]);
		return -1;
	}

	FILE *fp = NULL;
	char buf[200] = {};
	char **p = NULL;
	int len = 0;
	int ret = 0;

	fp = fopen(argv[1], "r+");
	if(NULL == fp)
	{
		perror("fopen");
		return -1;
	}

	while(1)
	{
		if(fgets(buf, 200, fp) == NULL)
			break;

		if(strlen(buf) == 1)
			continue;

		p = realloc(p, sizeof(char *)*(len+1));
		qsort(buf, strlen(buf)-1, 1, cmp_char);
		p[len] = strdup(buf);
		len++;
		memset(buf, 0, 200);
	}

	int i;
	fseek(fp, 0, SEEK_SET);
	for(i = 0; i < len; i++)
	{
		fprintf(fp, p[i]);
	}
	fclose(fp);
	return 0;
}

