def solution(M, N):
    if M == N: return M;
    elif M < N: return solution(M, N-M);
    elif M > N: return solution(M-N, N);

def solution2(M, N):
    while M != N:
        if M > N: M = M - N;
        else: N = N - M;
    return M;

def solution3(M, N):
    if M == N: return M;
    elif M > N:
        if M - N > N: L = N;
        else: L = M - N;
    else:
        if N - M > M: L = M;
        else: L = N - M;
    for C in range(L, 1, -1):
        if M % C == 0 and N % C == 0 : return C;

# assert(solution2(2000000000, 2000000000) == 2000000000);
# assert(solution2(2000000000, 2) == 2);
# assert(solution2(2000000000, 1000000005) == 5);
# assert(solution2(2, 2000000000) == 2);
# assert(solution2(1000000005, 2000000000) == 5);

# import cProfile;
# cProfile.run('solution2(2000000000, 2000000000)');
# cProfile.run('solution3(2000000000, 2000000000)');
# cProfile.run('solution2(2000000000, 2)');
# cProfile.run('solution3(2000000000, 2)');
