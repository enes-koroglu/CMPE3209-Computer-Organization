
import subprocess
import csv
import re

GDB = r"C:\riscv\xpack-riscv-none-elf-gcc-15.2.0-1\bin\riscv-none-elf-gdb.exe"

ELF = "main_O0.elf"
OUTPUT = "trace_O0.csv"

START = 0x800000D0
END = 0x80000300
MAX_STEPS = 20000

gdb = subprocess.Popen(
    [GDB, "--interpreter=mi2", "--quiet"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.STDOUT,
    text=True,
    bufsize=1
)

def command(cmd, wait_stop=False):
    gdb.stdin.write(cmd + "\n")
    gdb.stdin.flush()

    result = []
    completed = False

    while True:
        line = gdb.stdout.readline()
        if not line:
            raise RuntimeError("GDB connection closed")

        line = line.strip()
        result.append(line)

        if line.startswith("^error"):
            raise RuntimeError(line)

        if line.startswith(("^done", "^connected", "^running")):
            completed = True

        if wait_stop:
            if completed and line.startswith("*stopped"):
                return "\n".join(result)
        elif completed:
            return "\n".join(result)

def evaluate(expr):
    result = command("-data-evaluate-expression " + expr)
    match = re.search(r'\^done,value="([^"]+)"', result)

    if not match:
        raise RuntimeError("Cannot evaluate: " + result)

    return int(match.group(1).split()[0], 0)

def instruction(pc):
    result = command(
        f"-data-disassemble -s {pc} -e {pc + 4} -- 0"
    )
    match = re.search(r'inst="([^"]+)"', result)

    if not match:
        raise RuntimeError("Cannot disassemble: " + result)

    return match.group(1).replace("\\t", " ")

memory_ops = {
    "lb": ("R", 1),
    "lbu": ("R", 1),
    "lh": ("R", 2),
    "lhu": ("R", 2),
    "lw": ("R", 4),
    "sb": ("W", 1),
    "sh": ("W", 2),
    "sw": ("W", 4)
}

try:
    command(f"-file-exec-and-symbols {ELF}")
    command("-gdb-set pagination off")
    command("-target-select remote localhost:1234")
    command(f"-break-insert *{hex(START)}")
    command("-exec-continue", wait_stop=True)

    trace = []
    steps = 0

    while steps < MAX_STEPS:
        pc = evaluate("$pc")

        if pc == END:
            print("Program finished.")
            break

        asm = instruction(pc)
        parts = asm.strip().split(None, 1)
        op = parts[0]

        if op in memory_ops and len(parts) > 1:
            match = re.search(
                r'(-?(?:0x[0-9a-fA-F]+|\d+))\((\w+)\)',
                parts[1]
            )

            if match:
                offset = int(match.group(1), 0)
                base = match.group(2)

                address = (
                    evaluate("$" + base) + offset
                ) & 0xFFFFFFFF

                access_type, size = memory_ops[op]

                trace.append([
                    len(trace) + 1,
                    hex(pc),
                    op,
                    access_type,
                    hex(address),
                    size
                ])

        command("-exec-step-instruction", wait_stop=True)
        steps += 1

        if steps % 1000 == 0:
            print(
                f"{steps} instructions, "
                f"{len(trace)} memory accesses"
            )

    else:
        raise RuntimeError("MAX_STEPS reached")

    with open(OUTPUT, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow([
            "No", "PC", "Instruction",
            "Type", "Address", "Size"
        ])
        writer.writerows(trace)

    reads = sum(row[3] == "R" for row in trace)
    writes = sum(row[3] == "W" for row in trace)

    print("\nTRACE COMPLETED")
    print("Instructions:", steps)
    print("Memory accesses:", len(trace))
    print("Reads:", reads)
    print("Writes:", writes)
    print("Output:", OUTPUT)

finally:
    if gdb.poll() is None:
        gdb.stdin.write("-gdb-exit\n")
        gdb.stdin.flush()
        try:
            gdb.wait(timeout=10)
        except subprocess.TimeoutExpired:
            gdb.kill()
