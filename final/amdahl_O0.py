
import re

TOTAL_CYCLES = 6222

LOOP_START = 0x800001AC
LOOP_END = 0x8000024C

FUNCTION_START = 0x80000054
FUNCTION_END = 0x800000CC

cycles = 0
instructions = 0

with open("instruction_O0.txt", encoding="utf-8") as file:
    for line in file:
        match = re.search(
            r"(?:=>\s*)?0x([0-9a-fA-F]+).*?:\s*([a-z][a-z0-9.]*)",
            line
        )

        if not match:
            continue

        address = int(match.group(1), 16)
        opcode = match.group(2)

        in_loop = LOOP_START <= address <= LOOP_END
        in_function = FUNCTION_START <= address <= FUNCTION_END

        if not (in_loop or in_function):
            continue

        instructions += 1

        if opcode.startswith("mul"):
            cycles += 3
        elif opcode.startswith(("lw", "lh", "lb", "sw", "sh", "sb")):
            cycles += 2
        elif opcode.startswith(("b", "j")) or opcode in ("ret", "jalr"):
            cycles += 2
        else:
            cycles += 1

f = cycles / TOTAL_CYCLES
nc = 4

speedup = 1 / ((1 - f) + f / nc)
infinite_speedup = 1 / (1 - f)

print("AMDAHL RESULTS - O0")
print("-------------------")
print("Parallel instructions:", instructions)
print("Parallel cycles:", cycles)
print(f"f: {f:.6f}")
print(f"Parallel fraction: {f * 100:.2f}%")
print("Nc:", nc)
print(f"Speedup (4 cores): {speedup:.4f}")
print(f"Speedup (infinite cores): {infinite_speedup:.4f}")
