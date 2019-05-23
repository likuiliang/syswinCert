#ifndef ZHCN_TOKENIZER_H
#define ZHCN_TOKENIZER_H

#include "sqlite3.h"

#ifdef __cplusplus
#define EXTERN_C_BEGIN extern "C" {
#define EXTERN_C_END }
#else
#define EXTERN_C_BEGIN
#define EXTERN_C_END
#endif

EXTERN_C_BEGIN

/*
** Create an "tntoken" tokenizer.
*/
int fts5TntokenCreate(
        void *pCtx,
        const char **azArg,
        int nArg,
        Fts5Tokenizer **ppOut
);

/*
** Delete a "tntoken" tokenizer.
*/
void fts5TntokenDelete(Fts5Tokenizer *pTok);

/*
** Tokenize some text using the "tntoken" tokenizer.
**
** FTS5_TOKENIZE_QUERY     0x0001 select
** FTS5_TOKENIZE_PREFIX    0x0002
** FTS5_TOKENIZE_DOCUMENT  0x0004 insert
** FTS5_TOKENIZE_AUX       0x0008
*/
int fts5TntokenTokenize(
        Fts5Tokenizer *pTokenizer,
        void *pCtx,
        int flags,
        const char *pText,
        int nText,
        int (*xToken)(
                void *pCtx,
                int tflags,
                const char *pToken,
                int nToken,
                int iStart,
                int iEnd)
);

EXTERN_C_END
#endif //ZHCN_TOKENIZER_H