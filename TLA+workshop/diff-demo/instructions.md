# VSCode

1. Open your file and the given checkpoint.
2. In your file, open the command bar (ctrl+shift+p) and type "Compare".
3. Select "Compare Active File With".
4. Choose the checkpoint file.

# Mac/Linux Bash

`diff myfile checkpoint`

# Windows Powershell

`diff -CaseSensitive (gc myfile) (gc checkpoint)`