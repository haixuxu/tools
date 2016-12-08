#!/usr/bin/env node

var path = require('path'),
	fs = require('fs');
var exec = require('child_process').exec;
function handle(filepath) {
	process.stdout.write("正在处理" + filepath + "\n");
	exec("coffee -c " + filepath, function (err) {
		if (!err) {
			process.stdout.write("成功处理" + filepath + "\n");
		} else {
			process.stdout.write("失败处理" + filepath + "\n");
		}
	});
}


function task(root) {
	var filelist = fs.readdirSync(root),
		filename, state;
	for (var i = 0, ii = filelist.length; i < ii; i++) {
		filename = path.join(root, filelist[i]);
		if (fs.existsSync(filename) && /^\./.test(filelist[i]) == false) {
			state = fs.statSync(filename);
			if (state.isDirectory()) {
				task(filename);
			} else if (state.isFile()) {
				if (/\.coffee$/.test(filename)) {
					console.log(filename);
					handle(filename);
				}
			}
		}
	}
}

//start(config.root);

function main() { //parse args
	var argv = process.argv.splice(2), root;
	if (argv && argv.length != 0) { //user config
		var argstr = argv.join(" ");
		argstr = " " + argstr + " ";
		if (/\s-h\s/.test(argstr)) {
			console.log("use case:\n         node coffeebat.js -d [directory]");
			return;
		}
		if (/\s-d\s+\S+\s/.test(argstr)) {
			root = argstr.match(/\s-d\s+(\S+)\s/)[1];
		}
	}
	console.log("task work in " + root);
	task(root);
}

main();
