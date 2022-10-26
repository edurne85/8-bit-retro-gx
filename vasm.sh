vasm/vasm6502_oldstyle -c02 -Fbin -dotdir asm/$1.s -o out/$1.6502
vasm/vasm6502_oldstyle -c02 -dotdir asm/$1.s -o out/$1.txt
vasm/vasm6502_oldstyle -c02 -Fcdef -dotdir asm/$1.s -o out/$1.h

sed -e's/#define //' out/$1.h | sed -e's/\t0x/ = $/' | grep -v '^_' | sort -fu > out/$1.inc.s
# hexdump -e '1/1 "%04.4_ax  "' -e '16/1 "%02X ""\t"" "' -e '16/1 "%c""\n"' out/$1.6502 | less
