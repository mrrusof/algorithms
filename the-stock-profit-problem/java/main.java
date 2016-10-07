import java.util.Scanner;

public class main {

    private static int MAX_LEN = 1000000;

    private static int algG(int[] A) {
        int min = A.length > 0 ? A[0] : 0;
        int max = 0;
        for(int i = 0; i < A.length; i++)
            if(A[i] < min)
                min = A[i];
            else if(A[i] - min > max)
                max = A[i] - min;
        return max;
    }

    public static void main(String[] args) {
        int[] A = new int[MAX_LEN];
        int len = 0;
        int n;
        Scanner in = new Scanner(System.in);
        while(in.hasNextInt())
            A[len++] = in.nextInt();
        System.out.println(algG(A));
    }
}