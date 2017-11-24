#!/usr/bin/env node
/**
 * Created by toor on 17-10-24.
 */
var path = require('path'),
    fs = require('fs');
var exec = require('child_process').exec;
var beautify = require('js-beautify').js_beautify;
var formatOptions = {
    "space_after_anon_function": true,
};

function handle(filepath) {
    process.stdout.write("正在处理" + filepath + "\n");
    fs.readFile(filepath, 'utf-8', function (err, data) {
        if (err) throw err;

        fs.writeFile(filepath, beautify(data, formatOptions), {
            flag: 'w'
        }, function (err) {
            if (err) throw err;
            process.stdout.write("成功处理" + filepath + "\n");
        });
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
                if (/\.js$/.test(filename)) {
                    handle(filename);
                }
            }
        }
    }
}

//start(config.root);

function main() { //parse args
    var argv = process.argv.splice(2),
        root;
    if (argv && argv.length != 0) { //user config
        var argstr = argv.join(" ");
        argstr = " " + argstr + " ";
        if (/\s-h\s/.test(argstr)) {
            console.log("use case:\n         node btjsformat.js -d [directory]");
            return;
        }
        if (/\s-d\s+\S+\s/.test(argstr)) {
            root = argstr.match(/\s-d\s+(\S+)\s/)[1];
            console.log("task work in " + root);
            task(root);
        }
    }

}

main();