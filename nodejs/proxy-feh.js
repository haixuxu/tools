#!/usr/bin/env node
var exec = require('child_process').exec;
var argv=process.argv.slice(2);

function start(argv) {
    if (argv.length>0) {
    	console.log(1);
        exec('feh --bg-scale \'' + argv[0]+'\'',
            function (error, stdout, stderr) {
            if (error !== null) {
                console.log('exec error: ' + error);
            }
        });
    } else {
    	console.log(2);
        console.log('usage:\r\n' +
            '\tproxy-feh img');
    }

}

start(argv);
