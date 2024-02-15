
--normal search
$> grep 'word' filename

--will show all words (Californian, Californianaa)
$> grep California address.txt

--only word 'California' as a whole word
$> grep -w California address.txt

--case-insensitive
$> grep -i 'bar' file1 

--look for all files in the current and all of its subdirectories
$> grep -R 'httpd' .

--count the total number
$> grep -c 'nixcraft' frontpage.md


grep -r "192.168.1.5" /etc/

grep 'word' filename
 
# Interpret PATTERNS as fixed strings, not regular expressions (regex) when fgrep used.
grep -F 'word-to-search' file.txt
grep -F 'pattern' filename
 
grep 'word' file1 file2 file3
grep 'string1 string2'  filename
cat otherfile | grep 'something'
command | grep 'something'
command option1 | grep 'data'
grep --color 'data' fileName
grep [-options] pattern filename
grep -F [-options] words file


