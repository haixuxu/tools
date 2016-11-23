#!/usr/bin/env node
var exec = require('child_process').exec;
var argv = require('minimist')(process.argv.slice(2));

function start(argv) {
	if (argv.exec) {
		console.log('nohup ' + argv.exec + ' >/dev/null 2>&1 &');
		exec('nohup ' + argv.exec + ' >/dev/null 2>&1 &',
			function (error, stdout, stderr) {
				if (error !== null) {
					console.log('exec error: ' + error);
				}
			});
	}else{
		console.log('usage:\r\n' +
				'\tproxy-nohup --exec commandline');
	}

}

start(argv);


