#!/bin/bash

mkdir results
curl https://poggit.pmmp.io/releases.json'?latest-only&fields=id,name,version,artifact_url,api' | \
	php -r '$data = json_decode(stream_get_contents(STDIN));
		foreach($data as $release) {
			$ok = false;
			foreach($release->api as $api) {
				if($api->to{0} === "3" && $api->to{1} === "." && stripos($api->to, "alpha") === false) {
					$ok = true;
					break;
				}
			}
			if(!$ok) continue;
			echo "Testing $release->name\n";
			$json = shell_exec("wget -O test/plugin.phar https://poggit.pmmp.io/get/{$release->name}?prerelease");
			$PWD = getcwd();
			$json = shell_exec("docker run --rm -v $PWD/test:/input pmmp/dyncmdlist ./wrapper.sh $release->name");
			$json = json_encode(json_decode($json), JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
			file_put_contents("results/{$release->name}.json", $json);
		}'

