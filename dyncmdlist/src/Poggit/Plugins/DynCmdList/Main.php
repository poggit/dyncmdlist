<?php

namespace Poggit\Plugins\DynCmdList;

use pocketmine\command\PluginIdentifiableCommand;
use pocketmine\plugin\PluginBase;
use pocketmine\scheduler\ClosureTask;

final class Main extends PluginBase {
	public function onEnable() : void {
		$this->getScheduler()->scheduleDelayedTask(new ClosureTask(function(int $currentTick) : void{
			$this->rt();
		}), 1);
	}

	private function rt() : void {
		$report = $this->report();
		file_put_contents("/pocketmine/dyncmdlist-output.json", json_encode($report));
		$this->getServer()->shutdown();
	}

	private function report() : array {
		$pluginName = getenv("DYNCMDLIST_PLUGIN_NAME");
		$plugin = $this->getServer()->getPluginManager()->getPlugin($pluginName);
		if($plugin === null) {
			return [
				"status" => false,
				"error" => "Plugin $pluginName was not loaded",
			];
		}

		$commands = $this->getServer()->getCommandMap()->getCommands();

		$found = [];
		foreach($commands as $command) {
			if($command instanceof PluginIdentifiableCommand) {
				$cmdPlugin = $command->getPlugin();
				if($plugin === $cmdPlugin) {
					$found[] = $command;
				}
			}
		}

		return [
			"status" => true,
			"commands" => array_map(static function($cmd) {
				return [
					"name" => $cmd->getName(),
					"description" => $cmd->getDescription(),
					"usage" => $cmd->getUsage(),
					"aliases" => $cmd->getAliases(),
					"class" => get_class($cmd),
				];
			}, $found),
		];
	}
}
