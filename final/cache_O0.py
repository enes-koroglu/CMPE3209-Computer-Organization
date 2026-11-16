
import csv

CACHE_SIZE = 128
BLOCK_SIZE = 16
WAYS = 4
SETS = CACHE_SIZE // (BLOCK_SIZE * WAYS)

T1 = 1
T2 = 25

cache = [[] for _ in range(SETS)]

hits = 0
misses = 0
reads = 0
writes = 0

with open("trace_O0.csv", newline="") as f:
    reader = csv.DictReader(f)

    for row in reader:
        address = int(row["Address"], 16)
        access_type = row["Type"]
        size = int(row["Size"])

        if access_type == "R":
            reads += 1
        else:
            writes += 1

        first_block = address // BLOCK_SIZE
        last_block = (address + size - 1) // BLOCK_SIZE

        for block in range(first_block, last_block + 1):
            set_index = block % SETS
            tag = block // SETS
            lines = cache[set_index]

            if tag in lines:
                hits += 1
                lines.remove(tag)
                lines.insert(0, tag)
            else:
                misses += 1
                if len(lines) >= WAYS:
                    lines.pop()
                lines.insert(0, tag)

total = hits + misses
H = hits / total
Ts = T1 + (1 - H) * T2

print("CACHE RESULTS - MAIN O0")
print("-----------------------")
print("Sets:", SETS)
print("Reads:", reads)
print("Writes:", writes)
print("Hits:", hits)
print("Misses:", misses)
print("Total cache accesses:", total)
print(f"H: {H * 100:.4f}%")
print(f"Ts: {Ts:.4f} cycles")
