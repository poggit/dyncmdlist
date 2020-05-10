# dyncmdlist
A docker image that analyzes the commands registered by a plugin under default configuration.

## How to use
```
docker run --rm -v ${LOCAL_PHAR_PATH}:/input/plugin.phar pmmp/dyncmdlist ${PluginName}
```

The command list is returned via stdout in JSON format.

The JSON always contains a boolean property called `status`,
indicating whethre the run succeeded.
If `status` is `false`,
the error message is available as a human-readable string
in the `error` property.


