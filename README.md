Crypto module for TP-LINK & FAST Router

## Description

securityEncode ruby version, also gives guesses at plaintext    

>securityEncode(javascript) is used to encrypt password in web frontend before posting to verify authentification.   
```
function prototype:   
    securityEncode(short_key, password, long_key)
```

help to brute force tplink & fast router login page

### Notes

* ~~Considering that `Decryptor#decrypt` method gives all guesses at plaintext, which may take a lot of time, it's not recommended to invoke it.~~   
`Decryptor#decrypt` is replaced by `Decryptor#decrypt!` and itself returns the nested set containing characters corresponding to the index.
* The correct text is among these guesses without doubt but may be different in length.
* Keys required by securityEncode are likely to vary from devices (though three devices tested give the same).