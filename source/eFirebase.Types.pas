unit eFirebase.Types;

interface

type
 enumErrors = (NONE,
               EMAIL_EXISTS,
               OPERATION_NOT_ALLOWED,
               TOO_MANY_ATTEMPTS_TRY_LATER,
               INVALID_EMAIL,
               WEAK_PASSWORD,
               EMAIL_NOT_FOUND,
               USER_DISABLED,
               TOKEN_EXPIRED,
               USER_NOT_FOUND,
               INVALID_REFRESH_TOKEN,
               INVALID_GRANT_TYPE,
               MISSING_REFRESH_TOKEN,
               EXPIRED_OOB_CODE,
               INVALID_OOB_CODE,
               INVALID_ID_TOKEN,
               CREDENTIAL_TOO_OLD_LOGIN_AGAIN,
               INVALID_PASSWORD,
               UNKNOWN);

implementation

end.
