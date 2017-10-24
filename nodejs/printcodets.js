#!/usr/bin/env node
var argv = require('minimist')(process.argv.slice(2));
var fs = require('fs');

function start(argv) {
	if (argv.file) {
		fs.readFile(argv.file,'utf-8', function (err, data) {
			if(err){
				throw Error('filename read error');
			}
			data = data.replace(/\t/g, '\x1b[36m---->\x1b[0m').replace(/ /g, '\x1b[42m \x1b[0m');
			console.log(data);
		});
	}else{
		console.log('usage:\r\n' +
			'\tprintcodets --file filename');
	}

}

start(argv);