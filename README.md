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

If `status` is `true`,
the output is in this format:

```json
{
	"status": true,
	"commands": [
		{
			"name": "extractplugin",
			"description": "Extracts the source code from a Phar plugin",
			"usage": "\/extractplugin <pluginName>",
			"aliases": [],
			"class": "DevTools\\commands\\ExtractPluginCommand"
		}
	]
}
```

All 5 properties always exist inside each command entry.
