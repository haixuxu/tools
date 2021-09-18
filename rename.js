//https://stackoverflow.com/questions/53679316/trying-to-write-a-node-js-script-to-batch-rename-files-with-regex-and-search-rep
// Read directory
fs.readdir("./", (err, files) => {
  // Cicle files on current folder
  for (const file of files) {
    // Test regular expression
    if (/[A-Z]/g.test(file)) {
      // Add more logic to rename file
      fs.rename(file, "newFile.txt", (err) => {
        console.log("Renaming", file, "to", "newFile.txt");
        if (err) throw err;
      });
    }
  }
});
