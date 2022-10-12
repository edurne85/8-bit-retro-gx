vasm/vasm6502_oldstyle -Fbin -dotdir asm/$1.s -o out/$1.6502 && (hexdump -e '1/1 "%04.4_ax  "' -e '16/1 "%02X ""\t"" "' -e '16/1 "%c""\n"' out/$1.6502 | less)
