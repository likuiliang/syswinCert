//
// Created by Siyuan iOS Developer on 2018/10/11.
//


#include <dirent.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

#ifndef OPENSSL_DIR_FIX
#define OPENSSL_DIR_FIX

#include <TargetConditionals.h>

#if TARGET_OS_MAC ==1

FILE *fopen$UNIX2003( const char *filename, const char *mode )
{
    return fopen(filename, mode);
}

int fputs$UNIX2003(const char *res1, FILE *res2){
    return fputs(res1,res2);
}

int nanosleep$UNIX2003(int val){
    return usleep(val);
}

char* strerror$UNIX2003(int errornum){
    return strerror(errornum);
}

double strtod$UNIX2003(const char *nptr, char **endptr){
    return strtod(nptr, endptr);
}

size_t fwrite$UNIX2003( const void *a, size_t b, size_t c, FILE *d )
{
    return fwrite(a, b, c, d);
}

DIR * opendir$INODE64( char * dirName )
{
    return opendir( dirName );
}

struct dirent * readdir$INODE64( DIR * dir )
{
    return readdir( dir );
}

#endif

#endif