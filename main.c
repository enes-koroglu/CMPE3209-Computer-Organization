const int SID = 1230019; // last 9 digits: 001230019
int grades[43];
int bucket[5];
int mean = 0;
int below_count = 0;
int pass_count = 0;

unsigned int next_random(unsigned int x) {
    return 1664525u * x + 1013904223u;
}
int get_bucket(int grade) {
    if (grade < 50) return 0;
    if (grade < 65) return 1;
    if (grade < 75) return 2;
    if (grade < 85) return 3;
    return 4;
}
int main(void) {
    unsigned int state = (unsigned int)SID;
    int sum = 0;
    int pass_mark = 50 + SID % 10;
    for (int i = 0; i < 43; i++) {
        state = next_random(state);
        grades[i] = (int)((state >> 16) % 101u);
    }
    for (int i = 0; i < 43; i++) {
        int grade = grades[i];
        int category = get_bucket(grade);
        bucket[category]++;
        sum += grade;
        if (grade >= pass_mark) {
            pass_count++;
        }
    }
    mean = sum / 43;
    for (int i = 0; i < 43; i++) {
        if (grades[i] < mean) {
            grades[i] = grades[i] | 0x100;
            below_count++;
        }
    }
    while (1) {}
    return 0;
}
