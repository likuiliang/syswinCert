//
//  Created by luhongdeng on 2018/8/11.
//

#include "tn_tokenizer.h"

#include <string.h>

#define STRING_BUFFER_LENGTH 16384

char *subString(const char *str, unsigned int start, unsigned int end);

char toLower(char c);

char *subString(const char *str, unsigned int start, unsigned int end) {
    unsigned int n = end - start;
    static char strBuf[STRING_BUFFER_LENGTH];
    strncpy(strBuf, str + start, n);
    strBuf[n] = '\0';
    return strBuf;
}

char toLower(char c) {
    return ((c >= 'A') && (c <= 'Z')) ? (c + 'a' - 'A') : (c);
}

/*
** Create an "tntoken" tokenizer.
*/
int fts5TntokenCreate(
        void *pCtx,
        const char **azArg,
        int nArg,
        Fts5Tokenizer **ppOut
) {
    int rc = SQLITE_OK;
    *ppOut = (Fts5Tokenizer *) pCtx;
    return rc;
}

/*
** Delete a "tntoken" tokenizer.
*/
void fts5TntokenDelete(Fts5Tokenizer *pTok) {
}

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
) {
    int index = 0;
    int rc = SQLITE_OK;
    while (index < nText) {
        const unsigned char ch = (const unsigned char) pText[index];
        int nToken = 0;
        if (ch < 0xC0) {
            nToken = 1;
        } else if (ch < 0xF0) {
            if (ch < 0xE0) {
                nToken = 2;
            } else {
                nToken = 3;
            }
        } else {
            if (ch < 0xF8) {
                nToken = 4;
            } else if (ch < 0xFC) {
                nToken = 5;
            } else {
                nToken = 6;
            }
        }
        int iStartOffset = index;
        int iEndOffset = index + nToken;
        char *token = subString(pText, iStartOffset, iEndOffset);
        if (nToken == 1 && ch >= 'A' && ch <= 'Z') {
            *token = toLower(*token);
        }
        rc = xToken(pCtx, 0, token, nToken, iStartOffset, iEndOffset);
        if (rc != SQLITE_OK) {
            rc = SQLITE_DONE;
            goto end;
        }
        index += nToken;
    }

    goto end;
    end:
    if (rc == SQLITE_DONE) {
        rc = SQLITE_OK;
    }
    return rc;
}
