#!/usr/bin/env node
var exec = require('child_process').exec;
var opt = require('node-getopt').create([
		['e', 'exec=ARG', 'commandline'],
		//[''  , 'long'                , 'long option.'],
		['h', 'help', 'display this help'],
		['v', 'version', 'show version'],
		['s', '', 'short option.']
	])              // create Getopt instance
	.bindHelp()     // bind option 'help' to default action
	.parseSystem(); // parse command line

function start(opt) {
	console.log(opt);
	if (opt.exec) {
		exec('nohup ' + opt.exec + ' >/dev/null 2>&1 &',
			function (error, stdout, stderr) {
				if (error !== null) {
					console.log('exec error: ' + error);
				}
			});
	}

}

console.log(opt);
start(opt.options);