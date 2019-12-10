@setlocal
@set cdir=%CD%
@set cmp=%CD%\..\..\..\mads
@set PATH=%PATH%;%cmp%
@mads.exe %1.asm -x -t -l -i:%cmp%\base -o:%1.xex
@d:\Programs\Atari\Altirra\Altirra64.exe %1.xex