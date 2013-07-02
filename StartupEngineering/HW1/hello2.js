#!/usr/bin/env node
var fs = require('fs');
var outfile = 'hello.text';
var out = "Modify script to write out something different.\n";
fs.writeFileSync(outfile, out);
console.log("Script: " + __filename + "\nWrote: " + out + " To: " + outfile); 
